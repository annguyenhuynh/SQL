-- Problem 3: Find customers who have not placed any order yet in 2025 
--but had placed orders in every month in 2024 and at least 6 orders in 2023. 

with extracted_m_y as (
select 
	customer_id,
	extract (year from order_date) as order_year,
	extract (month from order_date) as order_month
from practice.past_orders
)

select 
	pc.name
from practice.past_customers pc
left join extracted_m_y emy on pc.id = emy.customer_id
group by pc.id, pc.name
having
	count (*) filter (where order_year=2025) =0
	and count (distinct order_month) filter (where order_year=2024)=12
	and count (distinct order_month) filter (where order_year=2023)>=6;

