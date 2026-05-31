--Show running total cost by usage date.
select
	usage_date,
	sum(cost) as daily_cost,
	sum(sum(cost)) over (order by usage_date) as running_total
from aws_costs
group by usage_date
order by usage_date;

--Show previous day's cost:
with total_cost as(
select
	usage_date,
	sum(cost) as total_cost
from aws_costs
group by usage_date
)

select 
	usage_date, 
	total_cost,
	lag(total_cost) over (order by usage_date) as prev_cost
from total_cost;

--Find accounts that never used Lambda.
select 
	a.account_id,a.account_name
from accounts a
where not exists (
	select 1
	from aws_costs ac
	where a.account_id = ac.account_id
	and ac.service='Lambda'
);

--Calculate percentage contribution of each service to total spend.
select 
	service, round(sum(cost)*100/(select sum(cost) as total from aws_costs),2) as percentage
from aws_costs
group by service

--Find top-spending service for each account.
with ranking as (
select 
	account_id,
	service,
	cost,
	row_number() over (partition by account_id order by cost desc) as top_spending_service
from aws_costs
)
select * from ranking
where top_spending_service=1

--Find accounts whose spending is above the average account spend.
with average as (
	select 
		account_id, 
		sum(cost) as total_spending
	from aws_costs
	group by account_id
)

select
	account_id,
	total_spending
from average
where total_spending > (select avg(total_spending) from average)

