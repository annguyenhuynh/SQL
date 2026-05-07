-- Q3. Find the hierarchy of managers for a given employee, i.e. "David"
with recursive cte as (

	select id, name, manager_id, designation, 1 as lvl
	from dev.emp_sample
	where name = 'David'

	union all
	select es.id, es.name, es.manager_id, es.designation, cte.lvl+1 as lvl
	from dev.emp_sample as es
	join cte on es.id = cte.manager_id
)

select * from cte 