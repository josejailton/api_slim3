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
     * @param $behaviour
     * @return Response
     */
    public function read($id = null, $behaviour = null)
    {
        $connection = $this->connection();

        $connection
            ->table('products')
            ->where('products.id = ?');

        $data = $connection
            ->fields([
                'products.id AS id', 'products.name AS name',
                'brands.id AS brand_id', 'brands.name AS brand_name',
                'suppliers.id AS supplier_id', 'suppliers.name AS supplier_name',
            ])
            ->join('brands', ['products.brand_id', 'brands.id'])
            ->join('suppliers', ['products.supplier_id', 'suppliers.id'])
            ->read($id);

        if (!is_array($data)) {
            return $this->response($data, 500);
        }

        $data = $this->with($data, $id);

        $product = $data[0];

        switch ($behaviour) {
            case 'details': {
                $peaces = $connection
                    ->join('prices', ['products.id', 'prices.product_id'])
                    ->join('peaces', ['prices.peace_id', 'peaces.id'])
                    ->join('peaces_details', ['peaces.id', 'peaces_details.peace_id'])
                    ->join('details', ['peaces_details.detail_id', 'details.id'])
                    ->join('variations', ['details.variation_id', 'variations.id'])
                    ->fields([
                            'peaces.id AS id', 'GROUP_CONCAT(details.name ORDER BY variations.order SEPARATOR " ") AS description']
                    )
                    ->group(['peaces.id'])
                    ->read($id);

                $connection
                    ->join(null)
                    ->group(null);

                $categories = [];//$connection->read($id);

                $product['peaces'] = $peaces;
                $product['categories'] = $categories;
                break;
            }
        }

        return $this->response($product, 200);
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
     * @param $id
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
                return [];
                break;
            }
        }
        return [];
    }
}