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
