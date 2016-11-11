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
    public function getProduct($id)
    {
        $data = $this->connection()
            ->table('products')->where('id = ?')->read($id);

        $status = 200;
        if (!is_array($data)) {
            $status = 500;
        }

        return $this->response($data, $status);
    }
}