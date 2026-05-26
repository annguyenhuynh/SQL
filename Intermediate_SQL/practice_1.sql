--Q1: Fetch duplicates
select user_name, user_email, count(*) as dups
from dev.users
group by 1,2
having count(*)>1;

--Q2: Fetch doctors who work in the same hospital using self-join
select 
	d1.name as doctor1_name, d2.name as doctor2_name
from
	dev.doctors d1
join dev.doctors d2
on d1.hospital=d2.hospital and d1.id > d2.id --avoid joining on themselves

--Q3: display only the details of employees who either earn the highest salary 
--or the lowest salary for each department from employee table
with ranked as (
	select 
		emp_id,
		emp_name,
		dept_name,
		salary,
		row_number() over(partition by dept_name order by salary desc) as rn_high,
		row_number() over(partition by dept_name order by salary asc) as rn_low
	from dev.employee
)

select 
	emp_id,
	emp_name,
	dept_name,
	salary ,
	case 
		when rn_high = 1 then 'HIGHEST'
		when rn_low = 1 then 'LOWEST'
	end as ranking
from ranked 
where rn_high=1 or rn_low=1
order by dept_name, salary