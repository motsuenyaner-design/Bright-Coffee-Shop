select*
from`brightlearn_case_study`.`default`.`coffee_shop_3`
limit 100;

-- How many stores do we have?
select distinct store_location
from `brightlearn_case_study`.`default`.`coffee_shop_3`;

--What is the period of the data?
SELECT MIN(transaction_date) as start_date,
       MAX(transaction_date) as end_date
FROM `brightlearn_case_study`.`default`.`coffee_shop_3`;

---What time does the store open and close?
SELECT MIN(transaction_time) as start_time,
       MAX(transaction_time) as end_time
FROM `brightlearn_case_study`.`default`.`coffee_shop_3`;

--How many products are we selling per store?
select store_location,
count(distinct product_id) as number_of_products
from `brightlearn_case_study`.`default`.`coffee_shop_3`
group by store_location;

--What are the different product category we have?
SELECT DISTINCT product_category
FROM `brightlearn_case_study`.`default`.`coffee_shop_3`;


--We adding new columns in our data, different date classifications
SELECT  transaction_date,
    store_location,
    product_category,
    product_type,
    product_detail,
    transaction_time,
  
DAYNAME(transaction_date) AS Day_name,
MONTHNAME(transaction_date) AS Month_name, 
--We are aggregating the data
   COUNT(transaction_id) AS number_of_sales, --- this will count for us the number of sales made
   SUM(transaction_qty) AS units_sold,-- this will add the number of units sold
   COUNT(DISTINCT product_id) AS unique_products,-- this counts the different products sold
   COUNT(DISTINCT store_id) AS number_of_stores,-- this counts all rows the number of stores
   
   ROUND(SUM(transaction_qty * CAST(REPLACE(unit_price,',','.')AS DOUBLE)),2)  AS revenue, -- this will add the revenue within the shop
CASE
    WHEN DAYNAME(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
    WHEN DAYNAME(transaction_date) IN ('Mon','Tue','Wed','Thu','Fri') THEN 'Weekday'
END AS day_classification,

CASE -- this here is classify the different times of the day
    WHEN hour(transaction_time) BETWEEN 6 AND 11 THEN '01. Morning'
    WHEN hour(transaction_time) BETWEEN 12 AND 17 THEN '02. Afternoon'
    WHEN hour(transaction_time) BETWEEN 18 AND 21 THEN '03. Evening'
END AS time_classification


FROM `brightlearn_case_study`.`default`.`coffee_shop_3`
Group by  transaction_date,
    store_location,
    product_category,
    product_type,
    product_detail,
    transaction_time;
