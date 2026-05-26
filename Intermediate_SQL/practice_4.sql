--Select meaningful translation
select * from dev.comments_and_translations;
select 
	coalesce (translation, comment) as output

from dev.comments_and_translations

--Check existing status
select 
	case when t.id is null then s.id
		when s.id is null then t.id
		when (s.id=t.id and s.name<>t.name) then t.id
	end as id,
	case when t.id is null then 'New in source'
		when s.id is null then 'New in target'
		when (s.id=t.id and s.name<>t.name) then 'Mismatch'
	end as status
from dev.source s
full join dev.target t on s.id = t.id
where s.id is null or t.id is null or (s.id=t.id and s.name<>t.name)

--Find each team that play with the opponent team once
with matches as
(select
	row_number() over (order by team_name) as id,
	t.*
from dev.teams t)
select 
	m1.team_name as team,
	m2.team_name as opponent
from matches m1
join matches m2
on m1.id < m2.id

-- Each team play with the opponent twice
with matches as
(select
	row_number() over (order by team_name) as id,
	t.*
from dev.teams t)
select 
	m1.team_name as team,
	m2.team_name as opponent
from matches m1
join matches m2
on m1.id <> m2.id

