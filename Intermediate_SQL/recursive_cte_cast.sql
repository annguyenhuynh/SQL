-- Recursive CTE - loop in programing
with recursive cte as (
	SELECT CAST('2025-01-01' AS DATE) as dt
	
	UNION ALL 
	
	SELECT (dt + INTERVAL '1 DAY')::DATE
	FROM cte
	WHERE dt < CAST('2025-01-07' AS DATE)
)

select
	cte.dt,
	sales.sales,
	COALESCE(sales.sales,0) as estimate,
	COALESCE(sales.sales,round((select avg(sales) as avg_sales from sales)),1) as estimate_2
from cte
left join sales on cte.dt = sales.dt;
	