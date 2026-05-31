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