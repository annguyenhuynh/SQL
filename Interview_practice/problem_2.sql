--Problem 2: Write a query that return customer name, latest order date and total value of the order. 
-- If a customer made multiple orders on the latest order date, then return the total value of the orders.
-- If a customer has not made any order yet, display "9999-01-01" as latest order date and 0 for total value
-- with date_cte as (
-- 	select customer_id,
-- 		max(order_date) as latest_order_date
-- 	from practice.orders
-- 	group by customer_id
-- )
select 
	c.name as customer_name,
	coalesce(lo.latest_order_date, date '9999-01-01'),
	coalesce(sum(o.total_cost), 0) as total_order
from practice.customers c
left join 
	(select customer_id, max(order_date) as latest_order_date
	from practice.orders o 
	group by customer_id
) lo on c.id = lo.customer_id
left join practice.orders o
on lo.customer_id = o.customer_id
and lo.latest_order_date = o.order_date
group by c.name, lo.latest_order_date

-- Instead of subquery, you can use cte as well