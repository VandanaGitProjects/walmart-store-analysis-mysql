select distinct(customer_id) from walmartsales group by customer_id having count(*)>1 order by customer_id ;

select customer_id,date, product_line,customer_type,Branch from walmartsales order by Customer_ID,date asc;

/* This query identifies repeat customers within a 30-day timeframe. */
SELECT DISTINCT(customer_id) AS 'Repeat Customers'
FROM
		(SELECT 
			a.customer_id,
			a.date AS FirstPurchase,
			b.date AS RepeatPurchase,
			DATEDIFF(b.date, a.date) AS DaysBetween
		FROM
			walmartsales a
		JOIN walmartsales b ON a.customer_id = b.customer_id
			AND b.date > a.date
			AND DATEDIFF(b.date, a.date) <= 30
		ORDER BY a.customer_id , a.date) AS WS
ORDER BY customer_id;





WITH customer_orders AS (
    SELECT 
        customer_id,
        date AS order_date,
        LAG(date,1) OVER (
            PARTITION BY customer_id ORDER BY date
        ) AS previous_order_date
    FROM walmartsales
)

SELECT 
   customer_id,
    previous_order_date AS FirstPurchase,
    order_date AS RepeatPurchase,
    DATEDIFF(order_date, previous_order_date) AS DaysBetween
FROM customer_orders
WHERE previous_order_date IS NOT NULL
  AND DATEDIFF(order_date, previous_order_date) <= 30
ORDER BY customer_id, previous_order_date;

