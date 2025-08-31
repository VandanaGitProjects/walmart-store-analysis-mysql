
/*
Task 10: Analyzing Sales Trends by Day of the Week
Walmart wants to analyze the sales patterns to determine
which day of the week
brings the highest sales.
*/
SELECT 
    DAYNAME(date) AS Days, 
    ROUND(SUM(total), 0) AS Sales
FROM
    walmartsales
GROUP BY days , DAYOFWEEK(date)
ORDER BY DAYOFWEEK(date); 
       
      
      
      
      
      
      
      
      
      
      
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT 
CONCAT('Week', WEEK(Date)) AS Week,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Sunday' THEN Total ELSE 0 END), 0) AS Sunday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Monday' THEN Total ELSE 0 END), 0) AS Monday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Tuesday' THEN Total ELSE 0 END), 0) AS Tuesday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Wednesday' THEN Total ELSE 0 END), 0) AS Wednesday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Thursday' THEN Total ELSE 0 END), 0) AS Thursday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Friday' THEN Total ELSE 0 END), 0) AS Friday,
  ROUND(SUM(CASE WHEN DAYNAME(date) = 'Saturday' THEN Total ELSE 0 END), 0) AS Saturday
FROM walmartsales
GROUP BY WEEK(date)
ORDER BY WEEK(date);


SELECT 
  CONCAT('Week', Week) AS Week,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Sunday' THEN Total ELSE 0 END), 0) AS Sunday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Monday' THEN Total ELSE 0 END), 0) AS Monday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Tuesday' THEN Total ELSE 0 END), 0) AS Tuesday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Wednesday' THEN Total ELSE 0 END), 0) AS Wednesday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Thursday' THEN Total ELSE 0 END), 0) AS Thursday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Friday' THEN Total ELSE 0 END), 0) AS Friday,
  ROUND(SUM(CASE WHEN DayOfWeek = 'Saturday' THEN Total ELSE 0 END), 0) AS Saturday
FROM (
  SELECT 
    Date,
    Total,
    WEEK(Date) AS Week,
    DAYNAME(Date) AS DayOfWeek
  FROM walmartsales
) AS sub
GROUP BY Week
ORDER BY Week;




