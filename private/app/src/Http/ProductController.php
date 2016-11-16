<?php

namespace Property\Http;
use Slim\Http\Response;

/**
 * Class ProductController
 * @package Property
 */
class ProductController extends AbstractController
{
    /**
     * @param $id
     * @return Response
     */
    public function read($id = null)
    {
        //select products.id as id, brands.brand_name as brand from products INNER JOIN brands ON products.brand_id = brands.id
        $data = $this->connection()
            ->collection('products INNER JOIN brands ON (products.brand_id = brands.id)')
            ->fields(['products.id as id', 'brands.brand_name as brand'])
            ->where('products.id = ?')->read($id);

        if (!is_array($data)) {
            return $this->response($data, 500);
        }

        $data = $this->with($data, $id);

        return $this->response($data, 200);
    }

    /**
     * @return Response
     */
    public function create()
    {

        return $this->response([], 200);
    }

    /**
     * @param $data
     * @return mixed
     */
    private function with($data, $id)
    {
        $with = $this->request->getQueryParam('with');
        if ($with) {
            $data[0][$with] = $this->switchWith($with, $id);
        }

        return $data;
    }

    /**
     * @param $with
     * @param $id
     * @return array
     */
    private function switchWith($with, $id)
    {
        switch ($with) {
            case 'stock': {
                return $this->connection()->table('stocks')
                    ->fields(['id', 'name', 'quantity'])->where('product_id = ?')->read($id);
                break;
            }
        }
        return [];
    }
}