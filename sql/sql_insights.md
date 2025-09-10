# SQL Insigths

Any other analysis/questions that may be useful based on the business problem, and their respective queries if applicable.

## Why-why Analysis

Based on Loss Elimination techniques, the first step to solve an issue is to identify its root cause. The next questions are designed to isolate different possible explainations for the delivery delay problem.

1. Number of days with each traffic condition per month in the last 6 months.

        SELECT 
            DATE_FORMAT(order_placed_at, '%Y-%m') AS 'year_month',
            COUNT(CASE WHEN traffic_condition = 'light traffic' THEN delivery_id ELSE NULL END) AS days_with_light_traffic,
            COUNT(CASE WHEN traffic_condition = 'moderate traffic' THEN delivery_id ELSE NULL END) AS days_with_moderate_traffic,
            COUNT(CASE WHEN traffic_condition = 'heavy traffic' THEN delivery_id ELSE NULL END) AS days_with_heavy_traffic
        FROM deliveries
        GROUP BY DATE_FORMAT(order_placed_at, '%Y-%m')
        ORDER BY order_placed_at DESC
        LIMIT 6;

2. Number of days with each weather condition per month in the last 6 months.

        SELECT DATE_FORMAT(order_placed_at, '%Y-%m') AS 'year_month',
            COUNT(CASE WHEN weather_condition = 'sunny' THEN delivery_id ELSE NULL END) AS days_with_sunnny_weather,
            COUNT(CASE WHEN weather_condition = 'foggy' THEN delivery_id ELSE NULL END) AS days_with_foggy_weather,
            COUNT(CASE WHEN weather_condition = 'rainy' THEN delivery_id ELSE NULL END) AS days_with_rainy_weather,
            COUNT(CASE WHEN weather_condition = 'windy' THEN delivery_id ELSE NULL END) AS days_with_windy_weather,
            COUNT(CASE WHEN weather_condition = 'cloudy' THEN delivery_id ELSE NULL END) AS days_with_cloudy_weather
        FROM deliveries
        GROUP BY DATE_FORMAT(order_placed_at, '%Y-%m')
        ORDER BY order_placed_at DESC
        LIMIT 6;

3. Number of orders per delivery person vs average delivery time by customer area.

        SELECT DISTINCT
            customer_area,
            COUNT(delivery_id) / COUNT(delivery_person_id) AS deliveries_per_delivery_persons,
            AVG(delivery_time_min) AS average_delivery_time
        FROM deliveries
        GROUP BY customer_area;

4. Average delivery time for days with top 20% of total orders vs average delivery time

        WITH deliveries_with_quantile AS (
            WiTH deliveries_per_date AS (
                SELECT
                    DATE_FORMAT(order_placed_at, '%Y-%m-%d') AS delivery_date,
                    COUNT(delivery_id) AS total_orders,
                    AVG(delivery_time_min) AS average_delivery_time,
                    AVG(delivery_time_min) - AVG(delivery_time_min) OVER (PARTITION BY DATE_FORMAT(order_placed_at, '%Y-%m')) AS diff_vs_monthly_avg_delivery_time,
                    RANK() OVER (ORDER BY COUNT(delivery_id) DESC) AS rnk,
                    ROW_NUMBER() OVER () AS row_
                FROM deliveries
                GROUP BY DATE_FORMAT(order_placed_at, '%Y-%m-%d')
            )
            SELECT
                deliveries_per_date.*,
                rnk / MAX(row_) OVER () AS quantile
            FROM deliveries_per_date
        )
        SELECT 
            delivery_date,
            total_orders,
            average_delivery_time,
            diff_vs_monthly_avg_delivery_time
        FROM deliveries_with_quantile
        WHERE quantile <= 0.2;

Queries 1 and 2 are designed to identify whether traffic or climate conditions have worsened in the last 6 months. The third query is to know if customer areas with higher demand have longer delivery times due to a shortage of delivery persons. Lastly, the fourth query aims to recognize if longer delivery times are expected on days with a higher number of orders than their monthly average.

## Query Validation

To check that the queries proposed here and in `sql_querys.sql` are correct, I created a series of mock tables using [Mockaroo](https://www.mockaroo.com) with the specifications provided in the instructions.

These tables were uploaded to a local server of MariaDB to validate the sql queries. If they were to be implemented elsewere, the following corrections should be made:

* Validate that all queries are compatible with the system's SQL version.
* Queries 1 and 2 from this file and query 2 from `sql_querys.sql` have harcoded values that should be updated according to traffic and weather categories from the real databases.