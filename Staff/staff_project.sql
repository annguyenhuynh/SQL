--COMMON TABLE EXPRESSIONS (CTE): Using CTE to find total and average salary of employees in region that have ‘east’ in their name
With CTE as (
select e.*
from data_sci.employees e
join data_sci.company_regions r
on e.region_id = r.id
where r.region_name like '%east%')
SELECT sum(salary), round(avg(salary),2)
FROM CTE;

--How many people are earning above/below average salary of his/her department? (Create view)
CREATE VIEW dept_avg_salary AS
SELECT s.department,
(s.salary > (select round(avg(s2.salary),2)
from public.staff s2
where s2.department = s.department)
)AS is_higher_than_average_salary
FROM public.staff s
ORDER BY s.department;
select *
from dept_avg_salary;
select department, is_higher_than_average_salary,count(*) as total_employees
from department_average_salary
group by 1, 2;

-- Who earns the most in his/her department? (subquery in where and self join)
select last_name, department, salary
from public.staff s
where salary = (select max(s2.salary)
 from public.staff s2
 where s2.department = s.department);
 
--Who earns the most in the company? (subquery in where)
select last_name, department, salary
from public.staff
where salary = (select max(salary)
 from public.staff);
 
----A person's salary compared to his/her department's average salary (subquery in select)
select s.last_name, s.department, s.salary,
(select round(avg(salary),2)
from public.staff s2
where s2.department = s.department) as department_average_salary
from public.staff s
order by s.department;

--Group employees within their department based on salary quartiles
select 
department,
last_name,
salary,
NTILE(4) over (partition by department order by salary desc) as salary_quartiles
from public.staff;

-- Width Bucket
-- Create 10 group of employee’s salary
select
last_name,
department,
salary,
width_bucket (salary,0, 150000,10)
from public.staff;

--Assume that people who earn at least $100,000 is executives
--Find the average salary of executives of each department
With executive_salary as (
select last_name, department, salary
from public.staff
group by department, last_name, salary
having salary >= 100000)
select department, round(avg(salary),2) as average_salary
from executive_salary
group by department
order by average_salary desc;

--Replace 'assistant' with 'asst'
SELECT
OVERLAY(job_title PLACING 'Asst.' FROM 1 FOR LENGTH ('Assistant')) as
shorten_job_title
FROM public.staff
WHERE job_title LIKE 'Assistant%';

--Using join to check missing information
--Full details info of employees with company division
select s.*, d.company_division
from public.staff s
INNER join public.company_divisions d
on s.department = d.department;
-- Results returned only 953 rows while we know we have 1000 employees
-- We want to check which employees are missing company division info
select s.*, d.company_division
from public.staff s
LEFT join public.company_divisions d
on s.department = d.department
WHERE company_division IS NULL;
-- --It seems like 47 employees working in books department are missing division info
