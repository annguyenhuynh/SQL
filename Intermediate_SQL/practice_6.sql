--Q5(a): Write a query to find all the Employee names whose name:
--• Begin with ‘A’
select *
from ah_practice.employees
where emp_name like 'A%';

--• Contains ‘a’ alphabet at second place
select *
from ah_practice.employees
where emp_name like '_a%';

--• Contains ‘Y’ alphabet at second last place
select *
from ah_practice.employees
where emp_name like '%y_';

--• Ends with ‘L’ and contains 4 alphabets
select *
from ah_practice.employees
where emp_name like '____l';

--• Begins with ‘V’ and ends with ‘A’
select *
from ah_practice.employees
where emp_name like 'V%a';

--Q5(b): Write a query to find the list of Employee names which is:

--• starting with vowels (a, e, i, o, or u), without duplicates
select distinct(emp_name)
from ah_practice.employees
where lower(emp_name) similar to '[aeiou]%';

--• ending with vowels (a, e, i, o, or u), without duplicates
select distinct(emp_name)
from ah_practice.employees
where lower(emp_name) similar to '%[aeiou]';

--• starting & ending with vowels (a, e, i, o, or u), without duplicates
select distinct(emp_name)
from ah_practice.employees
where lower(emp_name) similar to '[aeiou]%[aeiou]';

--Q6: Find Nth highest salary from employee table with and without using the TOP/LIMIT keywords.
select *,
	row_number() over (order by salary desc) as top_down_salary
from ah_practice.employees;

--Q8: Show the employee with the highest salary for each project
with cte as (
select e.emp_name, ed.project, e.salary,
	row_number() over (partition by ed.project order by e.salary desc ) as highest_salary
from ah_practice.employees e
join ah_practice.employee_detail ed
on e.emp_id = ed.emp_id
group by emp_name,ed.project, e.salary
)

select emp_name, project, salary from cte
where highest_salary = 1;

--Q9: Query to find the total count of employees joined each year
with cte as (
select 
	emp_id,
	extract(year from date_join) as year
from ah_practice.employee_detail
)

select 
	distinct(cte.year),
	count(ed.emp_id) over(partition by cte.year) as emp_count
from cte
join ah_practice.employee_detail ed on cte.emp_id = ed.emp_id
group by cte.year, ed.emp_id;

--Q10: Create 3 groups based on salary col
--salary less than 1L is low, between 1 -2L is medium and above 2L is High
select 
	emp_name,
	salary,
	case
		when salary < 100000 then 'Low'
		when salary >=100000 and salary < 200000 then 'Medium'
		when salary >= 200000 then 'High'
	end as salary_bucket
from ah_practice.employees