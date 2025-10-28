--FINDING ALL AVAILABLE DATA(ROWS AND COLUMNS)
SELECT*
    FROM BRIGHT_COFFEE;

    --find the date range(months) for the data
SELECT TRANSACTION_ID,
        MONTHNAME(TRANSACTION_DATE) AS MONTH_NAME,
        MIN(TRANSACTION_DATE) AS MIN_MONTH,
        MAX(TRANSACTION_DATE) AS MAX_MONTH
        FROM BRIGHT_COFFEE
        GROUP BY ALL;
--Data is from 01 January 2023 to 20 June 2023

-Finding open and closing time accross all stores.
SELECT MIN(TRANSACTION_TIME),
MAX(TRANSACTION_TIME)
FROM BRIGHT_COFFEE;
--Opening time was 06:00 ans latest running time was 20:59:38



--How do seasons of the year affect sales per store?
SELECT STORE_LOCATION,
CASE 
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Dec','Jan','Feb')THEN 'Summer'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Mar','Apr','May')THEN 'Autumn'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Jun','Jul','Aug')THEN 'Winter'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Sep','Oct','Nov')THEN 'Spring'
END AS SEASON,
COUNT(*) AS NUMBER_OF_TRANSACTIONS
FROM BRIGHT_COFFEE
GROUP BY  STORE_LOCATION,SEASON
ORDER BY NUMBER_OF_TRANSACTIONS DESC;
--Limiting Factor: data not fully representative of a 12 month cycle.
--Automn sales were stable accross the three stores, with mean of 26,697 sales
--Lower manhattan performed lower in summer and winter as compared to the other two outlets


--ESTABLISH WHICH SHOP PERFORMS BEST IN EACH TIME OF DAY BUCKET

--most sales are generated in the morning accross all stotres, howeverAstoria performed lower
--Hells Kithcens' sales are lower Midday and Lower Manhattan lower in the evening. 
--Astroria performed best at midday
-- TOTAL REVENUE ALL STORES
 SUM(UNIT_PRICE*TRANSACTION_QTY) AS TOTAL_REVENUE_ALL
 FROM BRIGHT_COFFEE;
 --698812.33 generated from 01 JAN UNTIL 30 JUN accross three outlets
--REVENUE BY STORE
STORE_LOCATION, 
        SUM(UNIT_PRICE*TRANSACTION_QTY) AS TOTAL_REVENUE_STORE
 FROM BRIGHT_COFFEE
 GROUP BY STORE_LOCATION 
 ORDER BY TOTAL_REVENUE_STORE DESC
 
 --All stores performed consistently, with Hell's Kitchen being number 1.
 --find THE best performing product across all stores, revenue important
SELECT DISTINCT PRODUCT_CATEGORY,
        STORE_LOCATION,
        SUM(UNIT_PRICE*TRANSACTION_QTY) AS TOTAL_REVENUE
        FROM BRIGHT_COFFEE
        GROUP BY PRODUCT_CATEGORY, STORE_LOCATION
        ORDER BY TOTAL_REVENUE DESC
        LIMIT 6;
--Coffee is the number one selling product accross all outlets, with tea following behind at second place
--product performance PER STORE , revenue important
SELECT DISTINCT PRODUCT_CATEGORY,
STORE_LOCATION,
SUM(UNIT_PRICE*TRANSACTION_QTY) AS TOTAL_REVENUE
FROM BRIGHT_COFFEE
GROUP BY PRODUCT_CATEGORY, STORE_LOCATION
ORDER BY TOTAL_REVENUE DESC; 





--Final DATA Selection SQL code

SELECT STORE_LOCATION,
TRANSACTION_DATE
TRANSACTION_ID,
PRODUCT_CATEGORY,
PRODUCT_TYPE,
PRODUCT_DETAIL,

TRANSACTION_TIME,
CASE 
    WHEN TRANSACTION_TIME BETWEEN '06:00:00' AND '10:59:59' THEN 'MORNING'
    WHEN TRANSACTION_TIME BETWEEN '11:00:00' AND '15:59:59' THEN 'MIDDAY'
    WHEN TRANSACTION_TIME BETWEEN '16:00:00' AND '20:59:59' THEN 'EVENING'
    ELSE 'UNKNOWN'
    END AS TIME_OF_DAY,
TRANSACTION_DATE,
    CASE 
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Dec','Jan','Feb')THEN 'Summer'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Mar','Apr','May')THEN 'Autumn'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Jun','Jul','Aug')THEN 'Winter'
    WHEN MONTHNAME(TRANSACTION_DATE) IN ('Sep','Oct','Nov')THEN 'Spring'
END AS SEASON,

COUNT(DISTINCT TRANSACTION_ID) AS NUMBEE_OF_SALES,
    
SUM (UNIT_PRICE*TRANSACTION_QTY) AS TOTAL_REVENUE_ALL

FROM BRIGHT_COFFEE
GROUP BY ALL;






    
