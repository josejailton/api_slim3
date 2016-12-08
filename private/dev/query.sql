SELECT * FROM categories;
SELECT *
FROM categories AS a LEFT JOIN categories AS b ON (a.id = b.category_id)
WHERE a.id = 3;

SELECT  
	#`t1`.`id`, `t1`.`name`, `t1`.`category_id`
	`t2`.*
FROM 
	`categories` AS `t1`,
	`categories` AS `t2`
WHERE
	`t1`.`id` = 3
;

SELECT * FROM categories;

SELECT @pv:=3;

SELECT @id;

SELECT 
	`t`.`id` as `id`, `t`.`name`, @id := `t`.`category_id` as `category_id`
FROM 
	(SELECT @id := 3) s,
	(SELECT * FROM categories ORDER BY category_id DESC) t
WHERE 
	(`t`.`id` = @id OR @id = 3);

SELECT @id := 3;

SELECT * FROM categories;

SELECT * FROM categories WHERE id = 3 OR id IN (
SELECT  @id := ( 
	SELECT category_id FROM categories WHERE id = @id
	) AS category
FROM
	( SELECT  @id := 3 ) vars
STRAIGHT_JOIN
        categories
WHERE 
	@id IS NOT NULL
);


SELECT 
	`products`.*, `prices`.*
	, GROUP_CONCAT(`details`.`name` ORDER BY `variations`.`order` SEPARATOR ' ') AS `description`
	#, `peaces`.`description`
FROM 
	`products`
	JOIN `prices` ON (`products`.`id` = `prices`.`product_id`)
	JOIN `peaces` ON (`prices`.`peace_id` = `peaces`.`id`)
	JOIN `peaces_details` ON (`peaces`.`id` = `peaces_details`.`peace_id`)
	JOIN `details` ON (`peaces_details`.`detail_id` = `details`.`id`)
	JOIN `variations` ON (`details`.`variation_id` = `variations`.`id`)
GROUP BY
	`peaces`.`id`
;




DELETE FROM categories WHERE id != 3;

INSERT INTO categories (name, _left, _right) VALUES('ELECTRONICS',1,20),('TELEVISIONS',2,9),('TUBE',3,4),
 ('LCD',5,6),('PLASMA',7,8),('PORTABLE ELECTRONICS',10,19),('MP3 PLAYERS',11,14),('FLASH',12,13),
 ('CD PLAYERS',15,16),('2 WAY RADIOS',17,18);



SELECT * FROM categories ORDER BY _left;

SELECT 
	(@sequence := @sequence + 1) AS sequence, parent.id, parent.name
FROM
	categories AS node,
    categories AS parent,
	(SELECT @sequence := 0) sequence
WHERE 
	TRUE
	AND node._left BETWEEN parent._left AND parent._right
	AND node.id = 3
ORDER BY 
	parent._left DESC;

SELECT 
	CONCAT( REPEAT(' ', COUNT(parent.name) - 1), node.name) AS name, node._left, node._right
FROM categories AS node,
        categories AS parent
WHERE node._left BETWEEN parent._left AND parent._right
GROUP BY node.name
ORDER BY node._left;

