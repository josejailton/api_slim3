<?php

namespace Property\Http;

use Slim\Http\Request;
use Slim\Http\Response;
use Property\Database\Connection;

/**
 * Class AbstractController
 * @package Property
 */
abstract class AbstractController
{
    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Response
     */
    protected $response;

    /**
     * @var Connection
     */
    protected $connection = null;

    /**
     * AbstractController constructor.
     * @param Request $request
     * @param Response $response
     * @param array $connection
     */
    public function __construct(Request $request, Response $response, array $connection)
    {
        $this->request = $request;
        $this->response = $response;
        $this->connection = new Connection($connection);
    }

    /**
     * @return Connection
     */
    public function connection()
    {
        return $this->connection;
    }

    /**
     * @param $data
     * @param int $statusCode
     * @return Response
     */
    public function response($data, $statusCode = 200)
    {
        return $this->response->withStatus($statusCode)->withJson(['data' => $data]);
    }
}