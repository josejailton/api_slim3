<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = new \Slim\App;

$app->get('/product/{id}', function (Request $request, Response $response, $parameters) {

    return $parameters['id'];
});
$app->run();
