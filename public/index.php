<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = new \Slim\App;

$app->get('/product/{id}', function (Request $request, Response $response, $parameters) {

		$db_produtos = new mysqli('fdb6.awardspace.net','1685805_imoveis','jose123456','1685805_imoveis');
		$response->withStatus(200);
		$data_array = array();
		$result = $db_produtos->query('SELECT slim_produtos.id AS id FROM slim_produtos WHERE slim_produtos.id = '.$args['id']);
		if ($result->num_rows > 0) {
			while ($row = $result->fetch_assoc()) {
				$data['id_produto'] = $row['id'];
				$data['nome_completo'] = $row['nome_completo'];
				$data['produto_query'] = $args['id'];
				array_push($data_array,$data); 
			}
			$result->free();
			return $this->response->withJson($data_array);
		} else {
			return $this->response->withJson(array('nenhum resultado'));
		}
});
    
    
    
});
$app->run();
