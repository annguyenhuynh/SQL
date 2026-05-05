--Most and Least expensive products in the category
select 
	p.*,
	first_value(product_name) over(partition by product_category order by price desc) as most_expensive_product,
	last_value(product_name) over (partition by product_category order by price desc
		range between unbounded preceding and unbounded following) as least_expensive_product
from dev.product p;

--Using window
select 
	p.*,
	first_value(product_name) over w as most_expensive_product,
	last_value(product_name) over w as least_expensive_product,
	nth_value(product_name, 2) over w as second_highest_product
from dev.product p
window w as (partition by product_category order by price desc
		range between unbounded preceding and unbounded following);

--NTILE
-- Group phones into groups of expensive, mid-range, and cheap buckets
select product_name,
	case when x.phone_buckets = 1 then 'Expensive'
		 when x.phone_buckets = 2 then 'Mid-range'
		 when x.phone_buckets = 3 then 'Cheap'
	end phone_category
from (
	select *,
		ntile(3) over (order by price) as phone_buckets
	from dev.product p
	where product_category = 'Phone') as x 

