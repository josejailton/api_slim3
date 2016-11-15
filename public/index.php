<?php

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require_once dirname(__DIR__) . '/app/bootstrap.php';

$database = require_once dirname(__DIR__) . '/config/database.php';

use Slim\Http\Request;
use Slim\Http\Response;

use Property\Http\ProductController;

$app->get('/{version}/product/{id}', function (Request $request, Response $response, $parameters) use ($database) {

    $controller = new ProductController($request, $response, $database);

    return $controller->getProduct($parameters['id']);
});

$app->post('/{version}/product', function (Request $request, Response $response, $parameters) use ($database) {

    $controller = new ProductController($request, $response, $database);

    return $controller->getProduct($parameters['id']);
});

$app->run();
