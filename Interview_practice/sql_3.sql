--Find the second highest AWS spend without using LIMIT.
with spending_by_service as(
	select
		service,
		sum(cost) as total_spending
	from aws_costs
	group by 1
)

select service, total_spending
from (
	select service, total_spending,
	dense_rank() over (order by total_spending) as rnk
	from spending_by_service
) as rank
where rnk=2;

--For each program office, return the highest-cost AWS service.
with spending as (
select 
	a.account_id,
	a.program_office,
	ac.service,
	sum(ac.cost) as total_cost
from accounts a
join aws_costs ac on a.account_id = ac.account_id
group by 1,2,3
)
select account_id,program_office, total_cost,service
from(
	select account_id,program_office, total_cost,service,
			row_number() over (partition by program_office order by total_cost desc ) as rnk
	from spending
) t
where rnk=1

--Identify days where total spending increased compared to the previous day.
with day_cost as (
select 
	cost,
	extract (day from usage_date) as day
from aws_costs
),
total_by_day as (
	select 
		day,
		sum(cost) as total_spending,
		lag(sum(cost)) over (order by day) as next_day_spending
	from day_cost
	group by day
)

select day, total_spending,next_day_spending
from total_by_day
where total_spending < next_day_spending

--Find accounts contributing more than 25% of total AWS spend.
with percentage as (
select account_id, 
		sum(cost) * 100 / (select sum(cost) from aws_costs) as pct

from aws_costs
group by account_id
)

select * from percentage
where pct > 25