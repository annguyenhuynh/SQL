--A. KPI'S
-- Total Revenue
select sum(total_price) as Revenue
from [Pizza DB].dbo.pizza_sales
;

-- Average Order Value
select 
	round((sum(total_price)/count (distinct order_id)),2) as Avg_per_order
from [Pizza DB].dbo.pizza_sales;

-- Average Order Value by customer
select 
	order_id,
	AVG(total_price) as Average_per_order
from [Pizza DB].dbo.pizza_sales
group by order_id
order by avg(total_price) desc;

-- Total Pizzas Sold
select 
	sum(quantity) as Total_pizzas_sold
from [Pizza DB].dbo.pizza_sales;

-- Total Orders
select 
	count(distinct order_id)
from [Pizza DB].dbo.pizza_sales;

-- Average pizza per order
select 
	cast(cast(sum(quantity) as decimal(7,2))/cast(count(distinct order_id) as decimal(7,2)) as decimal(7,2)) as average_pizza_per_order
from [Pizza DB].dbo.pizza_sales;

--B. DAILY TREND FOR TOTAL ORDERS
-- Extract number of total orders by days in a week
select 
	DATENAME(DW,order_date) as weekday, 
	count(distinct order_id) as total_orders_per_day
from [Pizza DB].dbo.pizza_sales
group by DATENAME(DW,order_date)
ORDER BY count(distinct order_id) desc;

--C. MONTHLY TREND FOR TOTAL ORDERS
select 
	DATENAME(MM, order_date) as month_no,
	count(distinct order_id) as total_orders_per_month
from [Pizza DB].dbo.pizza_sales 
group by DATENAME(MM,order_date) 
order by count(distinct order_id) desc;

-- D. % SALES BY PIZZA CATEGORY
select 
	 pizza_category,
	count(*) as Sales,
	round(100*sum(total_price)/(select sum(total_price) from [Pizza DB].dbo.pizza_sales),2) as PCT
from [Pizza DB].dbo.pizza_sales
group by pizza_category

--E. % SALES BY PIZZA SIZE
select 
	 pizza_size,
	round(100* SUM(total_price)/(select sum(total_price) from [Pizza DB].dbo.pizza_sales),2) as PCT

from [Pizza DB].dbo.pizza_sales
group by pizza_size
order by PCT desc;

-- F. TOTAL PIZZAS SOLD BY PIZZA CATEGORY
select 
	pizza_category,
	count(*) as Total_sales
from [Pizza DB].dbo.pizza_sales
group by pizza_category
order by Total_sales desc;

--G. TOP 5 PIZZAS BY REVENUE
select 
top 5 pizza_name,
sum(total_price) as Revenue
from [Pizza DB].dbo.pizza_sales
group by pizza_category,pizza_name
order by Revenue desc;

--H. BOTTOM 5 PIZZAS BY REVENUE
select 
top 5 pizza_name,
sum(total_price) as Revenue
from [Pizza DB].dbo.pizza_sales
group by pizza_category,pizza_name
order by Revenue;

--I. TOP 5 PIZZAS BY QUANTITY
select 
	top 5 pizza_name,
	sum(quantity) as Total_quantity
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_quantity desc;

--J. BOTTOM 5 PIZZAS BY QUANTITY
select 
	top 5 pizza_name,
	sum(quantity) as Total_quantity
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_quantity desc;

--K. TOP 5 PIZZAS BY TOTAL ORDERS
SELECT top 5 pizza_name, count(distinct order_id) as total_orders
FROM [Pizza DB].dbo.pizza_sales
group by pizza_name
order by total_orders desc;

--L. BOTTOM 5 PIZZAS BY TOTAL ORDERS
SELECT top 5 pizza_name, count(distinct order_id) as total_orders
FROM [Pizza DB].dbo.pizza_sales
group by pizza_name
order by total_orders;