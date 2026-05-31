--Find the most expensive AWS service.
with total_cost as (
	select service, sum(cost) as total_cost
	from aws_costs
	group by service
)

select * from total_cost
order by total_cost desc
limit 1;

--Find services whose total cost exceeds $200.
select 
	service,
	sum(cost) as total_cost
from aws_costs
group by service
having sum(cost) > 200;

--Calculate total AWS spend by program office.
select 
	a.program_office,
	sum(ac.cost) as total_spending
from accounts a 
join aws_costs ac on a.account_id = ac.account_id
group by a.program_office;

--Which account spent the most money?
with cte as (
	select a.account_id, a.account_name,
	sum(ac.cost) as total_spending
	from accounts a
	join aws_costs ac on a.account_id=ac.account_id
	group by a.account_id, a.account_name
	order by sum(ac.cost) desc
)

select 
	*,
	row_number() over (order by total_spending desc) as rnk
from cte

--2nd highest spending account
with cte as (
	select a.account_id, a.account_name,
	sum(ac.cost) as total_spending
	from accounts a
	join aws_costs ac on a.account_id=ac.account_id
	group by a.account_id, a.account_name
	order by sum(ac.cost) desc
),
ranking as (
select 
	*,
	row_number() over (order by total_spending desc) as rnk
from cte)

select * from ranking where rnk=2