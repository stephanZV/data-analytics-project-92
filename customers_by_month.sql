SELECT 
distinct concat(EXTRACT(year FROM sale_date),'-', extract(month FROM sale_date)) as selling_month,
SUM(sales_person_id) as total_customers,
sum(quantity*products.price) as income  
FROM sales
join products on
products.product_id = sales.product_id  
group by selling_month