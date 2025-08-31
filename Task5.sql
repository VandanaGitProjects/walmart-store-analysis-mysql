
/* This query finds the most frequently used payment method 
in each city to help Walmart adjust its marketing and payment options. */
-- step 1 : find total count of payment per city
WITH payment_counts AS (
    SELECT city, payment, COUNT(*) AS total_pay_count
    FROM walmartsales
    GROUP BY city, payment
),
-- step 2: find most frequently used payment method in each city by giving rank to all
ranked_methods AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_pay_count DESC) AS rnk
    FROM payment_counts
)
SELECT city, payment, total_pay_count
FROM ranked_methods
WHERE rnk=1 
ORDER BY total_pay_count desc;
