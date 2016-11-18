SELECT 
	`products`.`name`, `prices`.*
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