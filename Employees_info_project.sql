--1. How many rows are there in the employees table?
--2. What is the minimum and maximum salary of employees?
select
count(*), min(salary) as min_salary,
max(salary) as max_salary
from data_sci.employees;

--3. What's the number of employees, the minimum and maximum salary of employees in region 2?
select
count(*),
min(salary) as min_salary,
max(salary) as max_salary
from data_sci.employees
where region_id = 2;

--4. Query to find employees and their department ids where their salary is greater than 100,000 and the last name starts with letter b
select
department_id,
last_name,
salary
from data_sci.employees
where last_name like 'b%'
and salary > 100000
group by department_id, last_name, salary
order by department_id;

--5. Basic join: Query to information of employees who work in Canada
select
e.last_name,
e.email,
e.start_date,
e.salary,
e.job_title,
r.region_name
from data_sci.employees e
join data_sci.company_regions r
on e.region_id = r.id
where r.country_name = 'canada';

--6. Formatting Data
-- To capitalize the word: 
select upper(department_name)
from data_sci.company_departments;
-- To decapitalize the word:
select lower(department_name)
from data_sci.company_departments;
-- To capitalize the initial letter the word:
select initcap(department_name)
from data_sci.company_departments;
-- To combine values in multiple rows with a delimiter:
select concat_ws('-', last_name, job_title)
from data_sci.employees;

-- 7. Using HAVING clause to find subgroups
select
count(e.*) as num_employee,
d.department_name
from data_sci.employees e
join data_sci.company_departments d
on e.department_id = d.id
group by d.department_name
having count (e.*) > 50
order by count(e.*) desc;

--8. SUBQUERIES in SELECT: Compare the salary of each employee to the average salary of the department he/she belongs to
select
e1.last_name,
e1.job_title,
e1.salary,
(select round(avg(e2.salary),2) from data_sci.employees e2 where e1.department_id
= e2.department_id)
from data_sci.employees e1;

--9. SUBQUERIES in FROM: Calculate the average of employees who work in USA.
select
e1.last_name,
round(avg(e1.salary),2) as avg_salary
from
(select * from data_sci.employees join data_sci.company_regions
on data_sci.employees.region_id = data_sci.company_regions.id
where data_sci.company_regions.country_name = 'usa') e1
group by e1.last_name;

--10.SUBQUERIES in WHERE: Find the department that has employee that has the maximum salary
select
e.last_name,
e.salary,
d.department_name,
d.id as department_id
from data_sci.employees e
join data_sci.company_departments d
on e.department_id = d.id
where e.salary = (select max(salary) from data_sci.employees);

--11.Count employees in department where total salary paid to that department is greater than 5000,000
select
count(e.*) as num_employees,
d.department_name,
d.id,
sum(e.salary) as salary
from data_sci.employees e
join data_sci.company_departments d
on e.department_id = d.id
group by d.department_name, d.id
having sum(e.salary)>5000000;

--12.WINDOWS function: Query to find department_id, last_name, salary, sum of all salaries in department without using subqueries
select
department_id,
last_name,
salary,
sum(salary) over (partition by department_id)
from data_sci.employees;

--13.COMMON TABLE EXPRESSIONS (CTE): Using CTE to find total and average salary of employees in region that have ‘east’ in their name
With CTE as (
select e.*
from data_sci.employees e
join data_sci.company_regions r
on e.region_id = r.id
where r.region_name like '%east%')

SELECT sum(salary), round(avg(salary),2)
FROM CTE;