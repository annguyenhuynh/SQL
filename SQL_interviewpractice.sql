--1. Employees with the highest salary in a department
select 
	Fullname,
	DeptID,
	Salary
From(
select 
	DeptID,
	Fullname,
	Salary,
	ROW_NUMBER() over (partition by DeptID order by Salary desc) as rnk
	from dbo.Employees) as a
where rnk=1

--2. Employees with salary less than department average
select 
	Fullname,
	DeptID,
	salary 
from dbo.Employees 
where salary < (select AVG(salary) from dbo.Employees)
group by DeptID,Fullname,Salary;

--3. Employees with salary less than dept avg but more than avg of any other departments
with cte_1 as (
select 
	Fullname,
	DeptID,
	salary 
from dbo.Employees 
where salary < (select AVG(salary) from dbo.Employees)
group by DeptID,Fullname,Salary 
),

cte_2 as (
select 
	DeptID,
	avg(salary) as dept_avg
from dbo.Employees
group by DeptID)

select 
Fullname 
from cte_1
inner join cte_2 on cte_1.Salary > cte_2.dept_avg;

--4. Employees with same salary
select 
	distinct e1.Fullname, e2.Fullname,
	e1.Salary
from dbo.Employees e1, dbo.Employees e2
where e1.Salary = e2.Salary and e1.Fullname <> e2.Fullname

-- 5. Department where no employees has salry greater than their manager's salary 
select distinct DeptID
from dbo.Employees
where DeptID not in (
select e.DeptID
from dbo.Employees e
inner join dbo.Employees m on e.ManagerID = m.EmployeeID
where e.Salary > m.Salary);

-- 6. Find the difference between employee salary and the average of his/her department

with avg_salary as (
select DeptID, avg(salary) as avg_salary
from Employees
group by DeptID 
) 
select 
	EmployeeID,Fullname, avg_salary.DeptID,
	(Salary - avg_salary) as difference
from Employees
join avg_salary on Employees.DeptID = avg_salary.DeptID
group by avg_salary.DeptID,EmployeeID,Fullname,Salary,avg_salary;

--7. Employees whose salary is in top 2 percentile of the department
with cte as(
select 
distinct DeptID,
PERCENTILE_DISC(0.2)
within group (order by Salary desc) 
over (partition by DeptID) as top_2_percentile
from dbo.Employees
)

select EmployeeID, Fullname, cte.DeptID
from dbo.Employees
join cte on cte.DeptID = Employees.DeptID
where Salary >= top_2_percentile;

--8. Employees who earn more than every employee in dept no 2
select DeptID,EmployeeID, e.Salary
from dbo.Employees e
join
(select salary from Employees where DeptID =2) as a
on e.Salary > a.Salary
group by DeptID, EmployeeID, e.Salary;

--9. Return the departments with 2 or more employees whose salary is greater than 90% of respective department average salary
with cte as (
select 
DeptID,
round(0.9*avg(salary),2) as Ninety_percent_dptsalary
from dbo.Employees
group by DeptID
)

select 
	e.DeptID,
	e.EmployeeId,
	e.Fullname,
	Ninety_percent_dptsalary,
	e.Salary
from dbo.Employees e
join cte on e.DeptID = cte.DeptID 
where e.Salary > Ninety_percent_dptsalary 
group by e.DeptID,e.EmployeeID,e.Fullname,Ninety_percent_dptsalary,e.Salary

--10. Select top 3 departments with at least 2 employees and rank them according to the percentage of employees making over 100k
select 
DeptID,
100*sum(case when salary >= 100000 then 1 else 0 end)/count(EmployeeID) as percentage
from dbo.Employees
group by DeptID
having count(*) >=2
order by percentage desc;


