/*
This query identifies the most profitable product line within each branch.
It first calculates the total profit for each product line per branch,
then ranks them to find the top performer in each branch.
*/
SELECT branch, product_line, round(profit,2)
FROM (
    SELECT branch, product_line, SUM(gross_income - cogs) AS profit,
           RANK() OVER (PARTITION BY branch ORDER BY SUM(gross_income - cogs) DESC) AS rnk
    FROM walmartsales
    GROUP BY branch, product_line
) AS ranked
WHERE rnk = 1;



-------------------- 
/*
This query identifies the most profitable product line within each branch.
It first calculates the total profit for each product line per branch,
then ranks them to find the top performer in each branch.
*/

WITH ProductProfits AS (
    -- Step 1: Calculate the total profit for each product line in each branch.
    -- Profit is defined as the sum of (gross_income - cogs).
    SELECT
        Branch,
       product_line ,
        SUM(gross_income - cogs) AS total_profit
    FROM
        walmartsales
    GROUP BY
        Branch,
       product_line
),

RankedProfits AS (
    -- Step 2: Rank the product lines within each branch based on their total profit.
    -- The RANK() function is partitioned by Branch to reset the rank for each new branch.
    SELECT
        Branch,
        product_line,
        total_profit,
        RANK() OVER (PARTITION BY Branch ORDER BY total_profit DESC) AS profit_rank
    FROM
        ProductProfits
)

-- Step 3: Select only the product lines with a rank of 1 (the highest profit) for each branch.
SELECT
    Branch,
    product_line,
    ROUND(total_profit, 2) AS total_profit -- Rounding for cleaner presentation
FROM
    RankedProfits
WHERE
    profit_rank = 1;

