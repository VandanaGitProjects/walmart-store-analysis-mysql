
#Task 1: Top Branch by Sales Growth Rate
# Goal: Identify which branch has the highest month-over-month sales growth.

-- This CTE calculates the average monthly growth rate for each branch.
-- Step 1: Calculate total sales for each branch for each month.
-- We use DATE_FORMAT to extract month to group sales data.
WITH MonthlySales AS (
      SELECT
        Branch,
        DATE_FORMAT(Date, '%m') As sales_month,
        round(SUM(Total),2) AS monthly_sales
    FROM
        walmartsales 
    GROUP BY
        Branch,
        sales_month
        order by branch, sales_month
),
-- Step 2: For each branch, get the sales of the previous month.
-- We use the LAG() window function to look back one row (one month) within each branch's data.
SalesWithPreviousMonth AS (
    SELECT
        Branch,
        sales_month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (PARTITION BY Branch ORDER BY sales_month) AS previous_month_sales
    FROM
        MonthlySales
) ,
-- Step 3: Calculate the month-over-month growth rate for each branch.
-- The formula is ((Current Month Sales - Previous Month Sales) / Previous Month Sales) * 100
-- We handle the case where previous_month_sales is 0 to avoid division by zero errors.
MonthlyGrowthRate AS (
      SELECT
        Branch,
        sales_month,
        ((monthly_sales - previous_month_sales) / previous_month_sales) * 100 AS growth_rate
    FROM
        SalesWithPreviousMonth
	where previous_month_sales IS NOT NULL AND previous_month_sales > 0
) 
-- Step 4: Calculate the average growth rate for each branch and find the top performer.
-- We group by branch, calculate the average of the growth rates, and order the results
-- to see the branch with the highest average growth at the top.
SELECT
    Branch,
    round(AVG(growth_rate),2) AS average_growth_rate
FROM
    MonthlyGrowthRate
GROUP BY
    Branch
ORDER BY
    average_growth_rate DESC limit 1;
