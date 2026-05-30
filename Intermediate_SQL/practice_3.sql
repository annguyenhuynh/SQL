--Q6: From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.
with cold_days as (
select 
	id, 
	temperature,
	day,
	row_number() over(order by day) * interval '1 day',
	day - row_number() over(order by day) * interval '1 day' as grp
from dev.weather	
where temperature < 0
),
streak as (
select grp from cold_days
group by grp
having count(*) >=3
)

select c.temperature, c.day
from cold_days c
join streak s
on c.grp=s.grp
order by c.day

--Q7: write a SQL query to get the histogram of specialties (frequency table) of the unique physicians who have done the procedures 
--but never did prescribe anything.
select 
	ps.speciality,
	count(distinct physician_id) as num_physicians
from dev.physician_speciality ps
where exists (
	select 1
	from dev.patient_treatment pt
	join dev.event_category ec on ec.event_name = pt.event_name
	where pt.physician_id = ps.physician_id
	and ec.category = 'Procedure'
)
and not exists (
	select 1
	from dev.patient_treatment pt
	join dev.event_category ec on ec.event_name = pt.event_name
	where pt.physician_id = ps.physician_id
	and ec.category = 'Prescription'
)
group by 1
