--Q1(a): Find the list of employees whose salary ranges between 2L to 3L
select * 
from ah_practice.employees
where salary between 200000 and 300000;

--Q1(b): Write a query to retrieve the list of employees from the same city.
select e1.emp_name, e2.emp_name, e1.city
from ah_practice.employees e1
join ah_practice.employees e2 on e1.city=e2.city and e1.emp_id < e2.emp_id

--Q1(c): Query to find the null values in the Employee table.
select * 
from ah_practice.employees
where emp_id is null;

--Q2(a): Query to find the cumulative sum of employee’s salary.
select 
	e.emp_name, e.gender, e.city,
	sum(e.salary) over (order by e.emp_id) as cum_sum
from ah_practice.employees e

--Q2(b): What’s the male and female employees ratio?
select 
	(count(*) filter(where gender='M')*100/count(*)) as Malepct,
	(count(*) filter(where gender='F')*100/count(*)) as Femalepct
from ah_practice.employees;

--Q2(c): Write a query to fetch more than 50% records from the Employee table.
select * 
from ah_practice.employees
where emp_id >= (select count(emp_id)/2 from ah_practice.employees);

--Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’
--i.e 12345 will be 123XX
select emp_name,
	concat(substring(salary::text,1,length(salary::text)-2), 'XX') as masked_data
from ah_practice.employees;

