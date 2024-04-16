with ww as(
select sales.sales_person_id,
sales.customer_id,
min(sales.sale_date) 
from sales
inner join products on
products.product_id =sales.product_id
where products.price = 0
group by sales.sales_person_id,sales.customer_id,sales.sale_date
order by sales.customer_id 
),
www
as
(
 SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id order by min) AS rn
 from ww
)
select concat(customers.first_name,' ',customers.last_name) as customer,      
www.min as sale_date,
concat(employees.first_name,' ',employees.last_name) as seller
from www
inner join employees on
www.sales_person_id = employees.employee_id
inner join customers on
www.customer_id = customers.customer_id
where www.rn = 1