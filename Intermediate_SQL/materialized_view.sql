select 
	id, avg(val), count(*)
from dev.random_tab
group by id;

create materialized view mv_random_tab as 
select 
	id, avg(val), count(*)
from dev.random_tab
group by id;

