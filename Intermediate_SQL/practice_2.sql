--Q4: From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.
select 
	d1.name as doctor1, d1.speciality, d1.hospital,
	d2.name as doctor2, d2.speciality
from dev.doctors d1
join dev.doctors d2 on d1.hospital = d2.hospital
where d1.speciality <> d2.speciality and d1.id < d2.id

--Q5: From the login_details table, fetch the users who logged in 2 or more times.
with x as (
	select login_id, user_name, login_date,
	lag(login_date) over (partition by user_name order by login_date) as prev_date
from dev.login_details
),

y as (
	select login_id, user_name,login_date,
	case when login_date=prev_date + INTERVAL '1 day' then 1
	else 0 end as is_consecutive
	from x
)

select distinct user_name
from y
where is_consecutive=1