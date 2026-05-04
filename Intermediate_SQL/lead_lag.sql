select *,
	lag(salary,2,0) over(partition by dept_name order by emp_id),
	lead(salary,1,0) over(partition by dept_name order by emp_id)
from employee;

select 
	e.*,
	lag(salary) over (partition by dept_name order by emp_id),
	case
		when (e.salary) > lag(salary) over (partition by dept_name order by emp_id) then 'Higher than previous salary'
		when (e.salary) < lag(salary) over (partition by dept_name order by emp_id) then 'Lower than previous salary'
		when (e.salary) = lag(salary) over (partition by dept_name order by emp_id) then 'Same as previous salary'
	end as salary_range
from employee e