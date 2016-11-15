<?php

namespace Property\Http;

/**
 * Class ProductController
 * @package Property
 */
class ProductController extends AbstractController
{
    /**
     * @param $id
     * @return mixed
     */
    public function read($id = null)
    {
        $data = $this->connection()->table('products')->where('id = ?')->read($id);

        if (!is_array($data)) {
            return $this->response($data, 500);
        }

        $data = $this->with($data, $id);

        return $this->response($data, 200);
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