use internshala_wallmart;

-- This query detects Anomalies in walmart Sales Transactions
-- Step 1: Create a CTE to calculate the average of the 'Total' for each 'Product line'.
WITH avg_sales AS (
    SELECT product_line, 
           AVG(`Total`) AS avg_total
    FROM walmartsales
    GROUP BY product_line
)
-- Step 2: Join the main sales table with our new statistics table.
SELECT s.invoic_id, s.product_line, s.total,
       ROUND(a.avg_total, 2) AS AvgTotal,
       CASE 
           WHEN s.total > a.avg_total * 1.5 THEN 'High Anomaly'
           WHEN s.total < a.avg_total * 0.5 THEN 'Low Anomaly'
           ELSE 'Normal'
       END AS AnomalyType
FROM walmartsales s
JOIN avg_sales a
  ON s.product_line = a.product_line
WHERE s.total > a.avg_total * 1.5
   OR s.total < a.avg_total * 0.5;

