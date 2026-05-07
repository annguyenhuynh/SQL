-- Q1: Display number from 1 to 10 without using built-in function
with recursive numbers as (
	select 1 as n

	union 
	select 
	from numbers
);

select * from nub;

-- Q2: Find the hierarchy under the given name "Asha"
with recursive emp_hierarchy as 
	(select id, name, manager_id, designation, 1 as lvl
	from dev.emp_sample where name='Asha'

	union all
	select es.id, es.name, es.manager_id, es.designation, eh.lvl+1 as lvl
	from emp_hierarchy eh
	join dev.emp_sample es on es.manager_id = eh.id
	)
select eh2.id as emp_id, eh2.name as emp_name, es2.name as manager_name, eh2.lvl
from emp_hierarchy eh2
join dev.emp_sample es2 on es2.id = eh2.manager_id;

