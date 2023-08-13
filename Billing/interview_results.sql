SELECT
customer_id,customer_name,
(SUM(CASE WHEN EXTRACT(year from billing_creation_date) in (2019,2020,2021) THEN billing_amount END))/
(CASE 
WHEN(SUM(CASE WHEN EXTRACT(year from billing_creation_date)= '2019' THEN 1 ELSE 0 END))=0 THEN 1 ELSE 
SUM(CASE WHEN EXTRACT(year from billing_creation_date) = '2019' THEN 1 ELSE 0 END) END +
CASE
WHEN(SUM(CASE WHEN EXTRACT(year from billing_creation_date) = '2020' THEN 1 ELSE 0 END))=0 THEN 1 ELSE 
SUM(CASE WHEN EXTRACT(year from billing_creation_date) = '2020' THEN 1 ELSE 0 END) END + 
CASE
WHEN(SUM(CASE WHEN EXTRACT(year from billing_creation_date) = '2021' THEN 1 ELSE 0 END))=0 THEN 1 ELSE 
SUM(CASE WHEN EXTRACT(year from billing_creation_date) = '2021' THEN 1 ELSE 0 END) END
) as avg_billing_amount
FROM interview.billing
GROUP BY customer_id,customer_name
order by customer_id;