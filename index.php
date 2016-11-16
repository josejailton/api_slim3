<?php

define('__APP_ROOT__', __DIR__ . '/private');

require __APP_ROOT__ . '/vendor/autoload.php';

$app = require_once __APP_ROOT__ . '/app/bootstrap.php';

$database = require_once __APP_ROOT__ . '/config/database.php';

use Slim\Http\Request;
use Slim\Http\Response;

use Property\Http\ProductController;

$app->get('/{version}/product/{id}', function (Request $request, Response $response, $parameters) use ($database) {

    $controller = new ProductController($request, $response, $database);

    return $controller->read($parameters['id']);
});

$app->post('/{version}/product', function (Request $request, Response $response, $parameters) use ($database) {

    $controller = new ProductController($request, $response, $database);

    return $controller->create($parameters['id']);
});

$app->run();
