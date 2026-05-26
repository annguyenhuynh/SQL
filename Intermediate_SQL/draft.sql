select * from dev.patient_logs;


select
	account_id,
	extract(month from date) as month,
	count(distinct patient_id) as total
	
from dev.patient_logs
group by account_id,extract(month from date)
order by month