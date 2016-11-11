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
        $connection = $this->connection();

        $data = $connection->table('products')->where('id = ?')->read($id);

        $status = 200;
        if (!is_array($data)) {
            $status = 500;
        }
        $with = $this->request->getQueryParam('with');
        if ($with) {
            $more = [];
            switch ($with)
            {
                case 'stock': {
                    $more = $connection->table('stocks')
                        ->fields(['id', 'name', 'quantity'])->where('product_id = ?')->read($id);
                    break;
                }
            }
            $data[$with] = $more;
        }

        return $this->response($data, $status);
    }
}