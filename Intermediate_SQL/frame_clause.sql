--Most expensive products in the category
select 
	p.*,
	first_value(product_name) over(partition by product_category order by price desc) as most_expensive_product,
	last_value(product_name) over (partition by product_category order by price desc
		range between unbounded preceding and unbounded following) as least_expensive_product
from product p;

