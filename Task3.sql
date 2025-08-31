
/*
This query segments customers based on their total spending behavior.
It calculates the total spend for each customer, then classifies them into
High, Medium, or Low tiers using conditional logic.
This helps identify top-value customers and tailor marketing or loyalty strategies.
*/
SELECT 
    Customer_ID,
    CONCAT(ROUND(SUM(total), 0), ' $') AS Total_Spend,
    CASE
        WHEN SUM(total) > 25000 THEN 'High'
        WHEN SUM(total) > 20000 THEN 'Medium'
        ELSE 'Low'
    END AS Spending_Tier
FROM
    walmartsales
GROUP BY customer_ID
ORDER BY Total_spend DESC;


