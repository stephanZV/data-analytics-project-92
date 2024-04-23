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