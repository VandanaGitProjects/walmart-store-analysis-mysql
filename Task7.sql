/* This query finds the most popular product line for each customer type,
showing both the total number of purchases and the total sales revenue.
Popularity is ranked based on the purchase count.*/
WITH cutomer_type_count AS
(
SELECT customer_type, product_line, count(*) AS purchage_count, sum(total) AS total_sales
FROM walmartsales 
GROUP BY customer_type,product_line
),
customer_type_rank As
(  
 SELECT *, 
 RANK() OVER (partition by customer_type order by total_sales desc) as rnk
 FROM cutomer_type_count 
) SELECT customer_type AS 'Customer Type', 
		product_line AS 'Product Line', 
        purchage_count AS 'Purchage Count',
        round(total_sales,0) AS 'Total Sales' 
        FROM customer_type_rank WHERE rnk=1;

