<?php

namespace Property\Database;

use \PDO;
use \PDOStatement;

/**
 * Class Connection
 * @package Property\Database
 *
 * @method $this table(string $table)
 * @method $this collection(string $collection)
 * @method $this fields(array $fields)
 * @method $this where(array $where)
 * @method $this group(array $group)
 * @method $this order(array $order)
 */
class Connection
{
    /**
     * @var PDO
     */
    private $pdo;

    /**
     * @var array
     */
    private $clauses = [];

    /**
     * @var array
     */
    private $errors = [];

    /**
     * @var array
     */
    private $options = [];

    /**
     * Connection constructor.
     * @param array $options
     */
    public function __construct(array $options)
    {
        $this->options = $options;
    }

    /**
     * @param $name
     * @param $arguments
     * @return $this
     */
    public function __call($name, $arguments)
    {
        $this->clauses[$name] = $arguments[0];
        return $this;
    }

    /**
     * @param string $table
     * @param array $on
     * @param string $join
     * @return $this
     */
    public function join($table, $on = null, $join = 'INNER')
    {
        if (is_null($table)) {
            unset($this->clauses['join']);
        } else {
            if (!isset($this->clauses['join'])) {
                $this->clauses['join'] = [];
            }
            $on = implode(' = ', $on);
            $this->clauses['join'][] = "{$join} JOIN {$table} ON ({$on})";
        }
        return $this;
    }

    /**
     * @return array
     */
    public function getErrors()
    {
        return $this->errors;
    }

    /**
     * @return PDO
     */
    private function connect()
    {
        if (!$this->pdo) {

            try {

                $this->pdo = new PDO(
                    "mysql:host={$this->options['host']};dbname={$this->options['database']}",
                    $this->options['user'],
                    $this->options['password'],
                    [PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"]
                );

                $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            } catch (\PDOException $e) {

                $this->errors[] = $e->getMessage();
            }
        }
        return $this->pdo;
    }

    /**
     * @param $sql
     * @return PDOStatement
     */
    private function prepare($sql)
    {
        return $this->connect()->prepare($sql);
    }

    /**
     * @param $sql
     * @param array $parameters
     * @return mixed
     */
    private function execute($sql, array $parameters = [])
    {
        $statement = $this->prepare($sql);
        if ($statement->execute($parameters)) {
            return $statement->rowCount();
        }
        $this->errors = $statement->errorInfo();
        return null;
    }

    /**
     * @param $sql
     * @param array $parameters
     * @param null $fetch
     * @return array
     */
    private function fetch($sql, array $parameters = [], $fetch = null)
    {
        $statement = $this->prepare($sql);
        if ($statement and $statement->execute($parameters)) {
            $fetch = $fetch ? $fetch : PDO::FETCH_ASSOC;
            return $statement->fetchAll($fetch);
        }
        $this->errors = $statement->errorInfo();
        return null;
    }

    /**
     * @param array $parameters
     * @param bool $debug
     * @return null|string
     */
    public function create($parameters, $debug = false)
    {
        $collection = isset($this->clauses['table']) ? $this->clauses['table'] : (isset($this->clauses['collection']) ? $this->clauses['collection'] : '');
        $fields = isset($this->clauses['fields']) ? $this->clauses['fields'] : '/*FIELDS*/';
        $fields = is_array($fields) ? $fields : [$fields];
        $parameters = is_array($parameters) ? $parameters : [$parameters];
        $commands = [];
        $commands[] = 'INSERT INTO';
        $commands[] = $collection;
        $commands[] = '(' . (implode(', ', $fields)) . ')';
        $commands[] = 'VALUES';
        $commands[] = '(' . (str_repeat('?,', count($fields) - 2) . '?') . ')';
        $sql = implode(' ', $commands);
        if ($debug) {
            var_dump($sql);
        }
        if (!$this->execute($sql, $parameters)) {
            return null;
        }
        return $this->connect()->lastInsertId();
    }

    /**
     * @param array|null $parameters
     * @param bool $debug
     * @return array
     */
    public function read($parameters = null, $debug = false)
    {
        $collection = isset($this->clauses['table']) ? $this->clauses['table'] : (isset($this->clauses['collection']) ? $this->clauses['collection'] : '');
        $join = isset($this->clauses['join']) ? $this->clauses['join'] : null;

        $fields = isset($this->clauses['fields']) ? $this->clauses['fields'] : '*';
        $where = isset($this->clauses['where']) ? $this->clauses['where'] : null;
        $group = isset($this->clauses['group']) ? $this->clauses['group'] : null;
        $order = isset($this->clauses['order']) ? $this->clauses['order'] : null;
        $fields = is_array($fields) ? $fields : [$fields];

        $parameters = is_array($parameters) ? $parameters : [$parameters];

        $commands = [];
        $commands[] = 'SELECT';
        $commands[] = is_array($fields) ? implode(', ', $fields) : $fields;
        $commands[] = 'FROM ' . $collection;
        if ($join) {
            $commands[] = implode(' ', $join);
        }
        if ($where) {
            $where = is_array($where) ? $where : [$where];
            $commands[] = 'WHERE (' . implode(') AND (', $where) . ')';
        }
        if ($group) {
            $group = is_array($group) ? $group : [$group];
            $commands[] = 'GROUP BY ' . implode(', ', $group);
        }
        if ($order) {
            $order = is_array($order) ? $order : [$order];
            $commands[] = 'ORDER BY ' . implode(', ', $order);
        }
        $sql = implode(' ', $commands);
        if ($debug) {
            var_dump($sql);
        }

        return $this->fetch($sql, $parameters);
    }

    /**
     * @param array $set
     * @param array $parameters
     * @param bool $debug
     * @return null|string
     */
    public function update($set, $parameters = null, $debug = false)
    {
        $collection = isset($this->clauses['table']) ? $this->clauses['table'] : (isset($this->clauses['collection']) ? $this->clauses['collection'] : '');
        $where = isset($this->clauses['where']) ? $this->clauses['where'] : null;
        $fields = isset($this->clauses['fields']) ? $this->clauses['fields'] : '/*FIELDS*/';
        $fields = is_array($fields) ? $fields : [$fields];
        $set = is_array($set) ? $set : [$set];
        $parameters = is_array($parameters) ? $parameters : [$parameters];
        $commands = [];
        $commands[] = 'UPDATE';
        $commands[] = $collection;
        $commands[] = 'SET';
        $commands[] = is_array($fields) ? implode(', ', $fields) : $fields;
        if ($where) {
            $where = is_array($where) ? $where : [$where];
            $commands[] = 'WHERE (' . implode(') AND (', $where) . ')';
        }
        $sql = implode(' ', $commands);
        if ($debug) {
            var_dump($sql);
        }
        if ($parameters) {
            $parameters = array_merge($set, $parameters);
        }
        return $this->execute($sql, $parameters);
    }

    /**
     * @param array $parameters
     * @param bool $debug
     * @return mixed
     */
    public function destroy($parameters, $debug = false)
    {
        $collection = isset($this->clauses['table']) ? $this->clauses['table'] : (isset($this->clauses['collection']) ? $this->clauses['collection'] : '');
        $where = isset($this->clauses['where']) ? $this->clauses['where'] : null;
        $parameters = is_array($parameters) ? $parameters : [$parameters];
        $commands = [];
        $commands[] = 'DELETE FROM';
        $commands[] = $collection;
        if ($where) {
            $where = is_array($where) ? $where : [$where];
            $commands[] = 'WHERE (' . implode(') AND (', $where) . ')';
        }
        $sql = implode(' ', $commands);
        if ($debug) {
            var_dump($sql);
        }
        return $this->execute($sql, $parameters);
    }
}