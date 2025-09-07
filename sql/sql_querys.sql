-- Query 1
-- Top 5 customer areas with highest average delivery time in the last 30 days

SELECT 
	customer_area,
	AVG(delivery_time_min) AS average_delivery_time
FROM deliveries 

WHERE order_placed_at >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY customer_area
ORDER BY average_delivery_time DESC
LIMIT 5;

-- Query 2
-- Average delivery time per traffic condition, by restaurant area and cuisine type

SELECT
	restaurant_area,
	cuisine_type,
	AVG(CASE WHEN traffic_condition = 'light traffic' THEN delivery_time_min ELSE NULL END) AS average_delivery_time_light_traffic,
	AVG(CASE WHEN traffic_condition = 'moderate traffic' THEN delivery_time_min ELSE NULL END) AS average_delivery_time_moderate_traffic,
	AVG(CASE WHEN traffic_condition = 'heavy traffic' THEN delivery_time_min ELSE NULL END) AS average_delivery_time_heavy_traffic 
FROM deliveries	
LEFT JOIN orders 
	ON deliveries.delivery_id = orders.delivery_id
LEFT JOIN restaurants 
	ON orders.restaurant_id = restaurants.restaurant_id
GROUP BY restaurant_area, cuisine_type;

-- Query 3
-- Top 10 delivery people with the fastest average delivery time, considering only those with at least 50 deliveries and who are still active

WITH deliveries_by_person AS (
		SELECT
			delivery_persons.delivery_person_id,
			COUNT(delivery_id) AS total_deliveries,
			AVG(delivery_time_min) AS average_delivery_time,
			is_active
		FROM deliveries
		LEFT JOIN delivery_persons
			ON deliveries.delivery_person_id = delivery_persons.delivery_person_id
		GROUP BY delivery_persons.delivery_person_id)
SELECT * FROM deliveries_by_person
WHERE
	is_active = 1
	AND total_deliveries >= 50
ORDER BY average_delivery_time
LIMIT 10;

-- Query 4
-- The most profitable restaurant area in the last 3 months, defined as the area with the highest total order value

SELECT 
	restaurants.`area`,
	SUM(order_value) AS total_order_value
FROM restaurants
LEFT JOIN orders 
	ON restaurants.restaurant_id = orders.restaurant_id
LEFT JOIN deliveries
	ON orders.delivery_id = deliveries.delivery_id
WHERE
	order_placed_at >= DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH)
GROUP BY restaurants.`area`
ORDER BY total_order_value DESC
LIMIT 1;

-- Query 5
-- Identify whether any delivery people show an increasing trend in average delivery time
-- An increasing trend is marked with 1 in is_increasing_delivery_time

WITH average_deliveries_by_person AS (
		SELECT
			delivery_person_id,
			delivery_time_min AS y_,
			AVG(delivery_time_min) OVER (PARTITION BY delivery_person_id) AS y_bar,
			UNIX_TIMESTAMP(order_placed_at) AS x_,
			AVG(UNIX_TIMESTAMP(order_placed_at)) OVER (PARTITION BY delivery_person_id) AS x_bar
		FROM deliveries)
SELECT
 	delivery_person_id,
 	SUM((y_ - y_bar) * (x_ - x_bar)) / SUM((x_ - x_bar) * (x_ - x_bar)) > 0 AS is_increasing_delivery_time
FROM average_deliveries_by_person
GROUP BY delivery_person_id;