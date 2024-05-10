select count(customers.customer_id) as customers_count
from customers
/* запрос подсчитывает кол-во покупателей */
SELECT
    to_char(sale_date, 'yyyy-mm') AS selling_month,
    sum(sales_person_id) AS total_customers,
    sum(quantity * products.price) AS income
FROM sales
INNER JOIN products
    ON
        sales.product_id = products.product_id
GROUP BY selling_month
ORDER BY selling_month

/* запрос подсчитывает выручку по месяцам */
with bububub as (
    select 
        sales.sales_person_id as seller,
        count(sales.sales_id) as operations,
        sum(products.price * sales.quantity) as income
    from sales
    inner join products
        on
            sales.product_id = products.product_id
    group by sales.sales_person_id
)

select
    bububub.operations,
    bububub.income,
    concat(employees.first_name, ' ', employees.last_name) as seller
from employees
inner join bububub
    on
        employees.employee_id = bububub.seller
order by bububub.income desc
limit 10
/* прибыль и операции продавцов*/
with tab as
(select
        e.first_name || ' ' || e.last_name as seller,
        extract(isodow from s.sale_date) as week_day,
        trunc(sum(s.quantity * p.price)) as income,
        max(s.sale_date) as s_date
    from sales as s
    inner join employees as e on s.sales_person_id = e.employee_id
    inner join products as p on s.product_id = p.product_id
    group by 1, 2
    order by 2, 1
)
select
    seller,
    income,
    to_char(s_date, 'day') as day_of_week
from tab;
/* прибыль по дням */
with bububub as (
    select 
         sales.sales_person_id as seller,
        count(sales.sales_id) as operations,
        sum(products.price * sales.quantity) as income
    from sales
    inner join products
        on
            sales.product_id = products.product_id
    group by sales.sales_person_id
)
,
bbbb as (
    select
        concat(employees.first_name, ' ', employees.last_name) as seller,
        round(avg((bububub.income / bububub.operations))) as average_income
    from employees
    inner join bububub
        on
            employees.employee_id = bububub.seller
    group by employees.first_name, employees.last_name
)

select
    bbbb.seller,
    bbbb.average_income
from bbbb
where bbbb.average_income > (select avg(average_income) from bbbb)
order by bbbb.average_income
/* продавцы у кого средняя прибыль больше средней */
SELECT 
to_char(sale_date,'yyyy-mm')     sum(sales_person_id) AS total_customers,
    sum(quantity * products.price) AS income
FROM sales
INNER JOIN products
    ON
        sales.product_id = products.product_id
GROUP BY selling_month

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
