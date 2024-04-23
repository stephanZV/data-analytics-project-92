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