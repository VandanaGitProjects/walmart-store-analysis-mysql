
/* Walmart wants to reward its top 5 customers who have 
generated the most sales Revenue.*/
SELECT 
    customer_id, 
    ROUND(SUM(total), 0) AS Total_Sales_Volume
FROM
    walmartsales
GROUP BY customer_id
ORDER BY total_sales_volume DESC
LIMIT 5;
       
       