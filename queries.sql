select count(customers.customer_id) as customers_count
from customers
/* запрос подсчитывает кол-во покупателей */
SELECT 
to_char(sale_date,'yyyy-mm') as selling_month,
SUM(sales_person_id) as total_customers,
sum(quantity*products.price) as income  
FROM sales
join products on
products.product_id = sales.product_id  
group by selling_month
order by selling_month 
/* запрос подсчитывает выручку по месяцам */
with bububub as 
(select distinct sales.sales_person_id as seller,
count(sales.sales_id) as operations,
sum(products.price*sales.quantity) as income
from sales 
join products on
products.product_id = sales.product_id 
group by sales.sales_person_id 
)
select concat(employees.first_name,' ',employees.last_name) as seller,
bububub.operations,
bububub.income
from employees
join bububub on
employees.employee_id=bububub.seller
order by bububub.income desc
limit 10
/* прибыль и операции продавцов*/
with ww as(
SELECT
(products.price*sales.quantity) as income,
sales.sales_person_id,
TO_CHAR(sales.sale_date, 'ID') as day_of_week
FROM sales
join products on
products.product_id = sales.product_id 
group by sales_person_id,products.price,sales.quantity,sales.sale_date
),
www
as
(
select concat(employees.first_name,' ',employees.last_name) as seller,
ww.day_of_week,
round(ww.income) as income
from employees
join ww on 
employees.employee_id=ww.sales_person_id
)
select www.seller,
    CASE 
        when www.day_of_week = '1' THEN 'Monday'
        WHEN www.day_of_week = '2' THEN 'Tuesday'
        WHEN www.day_of_week = '3' THEN 'Wednesday'
        WHEN www.day_of_week = '4' THEN 'Thursday'
        WHEN www.day_of_week = '5' THEN 'Friday'
        WHEN www.day_of_week = '6' THEN 'Saturday'
        WHEN www.day_of_week = '7' THEN 'Sunday'
    end,
    www.income
FROM www;
/* прибыль по дням */
with bububub 
as 
(select distinct sales.sales_person_id as seller,
count(sales.sales_id) as operations,
sum(products.price*sales.quantity) as income
from sales 
join products on
products.product_id = sales.product_id 
group by sales.sales_person_id 
)
,
bbbb 
as
(
select 
concat(employees.first_name,' ',employees.last_name) as seller,
round(avg((bububub.income/bububub.operations))) as average_income
from employees
join bububub on
employees.employee_id=bububub.seller
group by employees.first_name,employees.last_name
)
select bbbb.seller,
bbbb.average_income
from bbbb
where bbbb.average_income > 276610
order by average_income
/* продавцы у кого средняя прибыль больше средней */
SELECT 
distinct concat(EXTRACT(year FROM sale_date),'-', extract(month FROM sale_date)) as selling_month,
SUM(sales_person_id) as total_customers,
sum(quantity*products.price) as income  
FROM sales
join products on
products.product_id = sales.product_id  
group by selling_month
/* лучшие продавцы месяца */
SELECT 
    CASE 
        WHEN age BETWEEN 16 AND 25 THEN '16-25'
        WHEN age BETWEEN 26 AND 40 THEN '26-40'
        ELSE '40+'
    END AS age_category,
    COUNT(*) AS count
FROM customers
GROUP BY age_category
ORDER BY age_category;
/* возрастные категории */