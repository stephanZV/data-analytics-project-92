SELECT 
to_char(sale_date,'yyyy-mm') as selling_month,
SUM(sales_person_id) as total_customers,
sum(quantity*products.price) as income  
FROM sales
join products on
products.product_id = sales.product_id  
group by selling_month
order by selling_month 
