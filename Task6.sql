
-- This query help to identify male monthly sales and  females monthly sales 
SELECT 
    YEAR(date) AS Year,
    MONTHNAME(date) AS Month,
    ROUND(SUM(CASE
                WHEN Gender = 'Female' THEN Total
                ELSE 0
            END),
            0) AS 'Female Sales',
    ROUND(SUM(CASE
                WHEN Gender = 'Male' THEN Total
                ELSE 0
            END),
            0) AS 'Male Sales'
FROM
    walmartsales
GROUP BY year , month
ORDER BY MIN(Date);