-- number 1
SELECT 
	MONTHNAME(order_date) month_name
	, ROUND(SUM(after_discount)) total_transaction_value 
FROM 
	order_detail od 
WHERE 
	EXTRACT(YEAR FROM order_date) = 2021
	and is_valid = 1
group by 
	1 
order by 
	2 desc;


-- number 2
SELECT 
	sd.category
	, ROUND(SUM(after_discount), 0) total_transaction_value 
FROM 
	order_detail od 
LEFT JOIN 
	sku_detail sd ON od.id_sku = sd.id_sku 
WHERE 
	EXTRACT(YEAR FROM order_date) = 2022 
	AND is_valid = 1 
GROUP BY 
	1 
ORDER BY 
	2 DESC;


-- number 3
SELECT
    category,
    ROUND(SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2021 THEN after_discount ELSE 0 END), 0) AS total_value_2021,
    ROUND(SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2022 THEN after_discount ELSE 0 END), 0) AS total_value_2022,
    CASE WHEN 
        ROUND(SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2021 THEN after_discount ELSE 0 END), 0) <
        ROUND(SUM(CASE WHEN EXTRACT(YEAR FROM order_date) = 2022 THEN after_discount ELSE 0 END), 0) 
    THEN 'Increase' ELSE 'Decrease' END AS progres
FROM
    order_detail od
JOIN
    sku_detail sd ON od.id_sku = sd.id_sku
WHERE
    od.is_valid = 1
GROUP BY
    1
HAVING
    total_value_2022 > total_value_2021
    OR total_value_2022 < total_value_2021;

   
-- number 4
SELECT 
    pd.payment_method,
    COUNT(DISTINCT od.id_order) AS total_unique_orders
FROM 
    order_detail od
LEFT JOIN 
    payment_detail pd ON od.id_payment = pd.id_payment
WHERE 
    od.is_valid = 1
    AND YEAR(od.order_date) = 2022
GROUP BY 
    pd.payment_method
ORDER BY 
    2 DESC
LIMIT 5;

   
-- number 5
with pb as(
SELECT
    CASE
        WHEN LOWER(sd.sku_name) LIKE '%samsung%' THEN 'Samsung'
        WHEN LOWER(sd.sku_name) LIKE '%apple%' OR LOWER(sd.sku_name) LIKE '%iphone%' 
        OR LOWER(sd.sku_name) LIKE '%macbook%' THEN 'Apple'
        WHEN LOWER(sd.sku_name) LIKE '%sony%' THEN 'Sony'
        WHEN LOWER(sd.sku_name) LIKE '%huawei%' THEN 'Huawei'
        WHEN LOWER(sd.sku_name) LIKE '%lenovo%' THEN 'Lenovo'
        ELSE 'Others'
    END AS product_brand,
    SUM(od.after_discount) AS total_transaction_value
FROM
    order_detail od
LEFT JOIN
    sku_detail sd ON od.id_sku = sd.id_sku
WHERE
    od.is_valid = 1
GROUP BY
    1
ORDER BY
    2 DESC
)
SELECT * FROM pb WHERE product_brand != 'Others';
