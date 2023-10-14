--1. How many Olympic games have been held?
select count(distinct Games) as "Total Olympic events"
from olympics.dbo.athlete_events$;

--2. List all Olympic games held so far
select distinct Year,Season, City
from olympics.dbo.athlete_events$
order by Year;

-- 3. Total number of nations who participated in each olympic games
select 
	Games,
	count(distinct NOC) as "Number of countries"
from olympics.dbo.athlete_events$
group by Games
order by Games;

--4. Which year saw the highest and lowest no of countries participating in the Olympics?
--Lowest number of participating countries
select
	top(1)
	Year,
	count(distinct NOC) as games
from olympics.dbo.athlete_events$
group by Year
order by games;

--Highest number of participating countries
select
	top(1)
	Year,
	count(distinct NOC) as games
from olympics.dbo.athlete_events$
group by Year
order by games desc;

--5. Which nation has participated in the Olympic games?
select 
	NOC as "country",
	count(distinct Games) as "games"
from olympics.dbo.athlete_events$
group by NOC
having count(distinct Games) = 51;

--6. Identify the sports that was played in all summer olympics
	-- Warning: There are many sports that have been played in the summer games, but only few were played in ALL summer games. 
	-- We need to find the total number of summer olympic games, all the sports that have been played in summer games, and 
	-- filter out those that appear in all the games.
with total_games as (
select
	count(distinct Games) as "Total Games"
from olympics.dbo.athlete_events$
where Season = 'Summer'
),

games_played as(
select
	distinct Games,Sport 
from olympics.dbo.athlete_events$
where Season = 'Summer'
),

all_summer as (
select 
	Sport,
	count(*) as "Number of Games"
from games_played
group by Sport)

select * from all_summer
join total_games on total_games.[Total Games] = all_summer.[Number of Games];


--7. Which sports was just played only once in the Olympics?

with summer_games  as(
select 
	distinct(Games), Sport 
from olympics.dbo.athlete_events$
where Season = 'Summer' 
)
select 
Sport,
count(1) as "Number of games"
from summer_games
group by Sport
having count(1) = 1;


--8. Total number of sports played in each olympic games
select 
	Games,
	count(distinct Sport) as "Total sports played"
from olympics.dbo.athlete_events$
group by Games
order by Games;

--9.Fetch details about the oldest athlete who wins the gold medal
select
	top(2)
	Name,
	Sex,
	Age,
	Team,
	NOC,
	Season,
	Games,
	City
from olympics.dbo.athlete_events$
where Medal = 'Gold'
order by Age desc;


--10. Find the ratio of male and female participants in all olympic games
select 
	sex,
	count(*) as cnt
from olympics.dbo.athlete_events$
group by Sex

select
concat ('1: ', round(196594*1.00 / 74522*1.00,2)) as ratio;


--11. Find the top 5 athletes who have won the most gold medals
select 
	top(5)
	Name as "Athlete",
	Team,
	count (*) as "Total Gold medals"
from olympics.dbo.athlete_events$
where Medal = 'Gold' 
group by Name, Team
order by count(*) desc;

--12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
select 
TOP 5
	Name,
	count(*) as "Total number of medals"
from olympics.dbo.athlete_events$
where Medal is NOT NULL
group by Name 
order by count(*) desc;

--13. Fetch the top 5 most successful countries in olympics. Success is defined by the number of medals won
select 
TOP 5
	Team,
	NOC,
	count(*) as "Total number of medals"
from olympics.dbo.athlete_events$
where Medal is NOT NULL
group by Team,NOC 
order by count(*) desc;

--14. List down total gold, silver, bronze medals won by each country
with gold as (
select 
	distinct Team,
	count(*) as "Gold medals"
from olympics.dbo.athlete_events$
where Medal = 'Gold'
group by Team
),

silver as (
select 
	distinct Team,
	count(*) as "Silver medals"
from olympics.dbo.athlete_events$
where Medal = 'Silver'
group by Team 
),
bronze as (
select 
	distinct Team,
	count(*) as "Bronze Medals"
from olympics.dbo.athlete_events$
where Medal = 'Bronze'
group by Team 
) 
select 
	distinct gold.Team
	, "Gold Medals",
	"Silver Medals",
	"Bronze Medals"
from gold 
join silver on gold.Team = silver.Team 
join bronze on silver.Team = bronze.Team;

--15.  List down total gold, silver, bronze medals won by each country correspoding to each olympic game
with gold as (
select 
	distinct Team,
	count(*) as "Gold medals"
from olympics.dbo.athlete_events$
where Medal = 'Gold'
group by Team
),

silver as (
select 
	distinct Team,
	count(*) as "Silver medals"
from olympics.dbo.athlete_events$
where Medal = 'Silver'
group by Team 
),
bronze as (
select 
	distinct Team,
	count(*) as "Bronze Medals"
from olympics.dbo.athlete_events$
where Medal = 'Bronze'
group by Team 
) 
select 
	distinct gold.Team,
	a.Games,
	"Gold Medals",
	"Silver Medals",
	"Bronze Medals"
from gold 
join silver on gold.Team = silver.Team 
join bronze on silver.Team = bronze.Team
join olympics.dbo.athlete_events$ a on gold.Team = a.Team
group by a.Games,gold.Team,"Gold medals","Silver medals","Bronze Medals"
order by a.Games;

--16. Identify the country that won the most gold, silver, and bronze medals in each olympic games
with pvdata as (
select *
from (
	select
	[Games],
	[NOC],
	[Medal]
from olympics.dbo.athlete_events$
where Medal != 'NA'
) AS medalsdata 

pivot(
	count([Medal])
	for [Medal]
	in ([Gold],[Silver],[Bronze]) 
) as pivottable 
)
select 
	distinct Games,
	concat (
		FIRST_VALUE(NOC) over (partition by Games order by Gold desc), '-',
		first_value(Gold) over (partition by Games order by Gold desc)) as MaxGold,
	concat (
		first_value(NOC) over (partition by Games order by Silver desc), '-',
		FIRST_VALUE(Silver) over (partition by Games order by Silver desc)) as MaxSilver,
	concat(
		first_value(NOC) over (partition by Games order by Bronze desc), '-',
		FIRST_VALUE(Bronze) over (partition by Games order by Bronze desc)) as MaxBronze 
from pvdata
group by Games, NOC, Gold,Silver,Bronze;

--17. First part is same as question 16 and the second part is about countries winning the most medals in each olympic games

with medals as (
select 
	Games,
	NOC,
	count(Medal) "Total Medals"
from olympics.dbo.athlete_events$
where Medal != 'NA'
group by Games, NOC
),
rank as (
select 
	Games,
	NOC,
	row_number() over (partition by Games order by "Total Medals" desc) as rnk 
from medals 
), 

pvdata as (
select *
from (
	select
	[Games],
	[NOC],
	[Medal]
from olympics.dbo.athlete_events$
where Medal != 'NA'
) AS medalsdata 

pivot(
	count([Medal])
	for [Medal]
	in ([Gold],[Silver],[Bronze]) 
) as pivottable 

)
select 
	distinct pvdata.Games,
	rank.NOC,
	concat (
		FIRST_VALUE(pvdata.NOC) over (partition by pvdata.Games order by Gold desc), '-',
		first_value(Gold) over (partition by pvdata.Games order by Gold desc)) as MaxGold,
	concat (
		first_value(pvdata.NOC) over (partition by pvdata.Games order by Silver desc), '-',
		FIRST_VALUE(Silver) over (partition by pvdata.Games order by Silver desc)) as MaxSilver,
	concat(
		first_value(pvdata.NOC) over (partition by pvdata.Games order by Bronze desc), '-',
		FIRST_VALUE(Bronze) over (partition by pvdata.Games order by Bronze desc)) as MaxBronze 
from pvdata
join rank on pvdata.Games = rank.Games
where rank.rnk = 1
group by pvdata.Games, pvdata.NOC, rank.NOC, Gold,Silver,Bronze;

--18. List all countries who never won a gold medal but have won silver and bronze medals
select * from (
select 
	[Games],
	[NOC],
	[Medal]
from olympics.dbo.athlete_events$ 
where Medal != 'NA'
) as a
pivot(count(Medal)
for Medal in ([Gold],[Silver],[Bronze])) as ptable
where Gold =0
order by Games;

--19. In which sports/events India has won the highest number of medals?

select 
	Sport,
	count(Medal) as medals
from olympics.dbo.athlete_events$ ae
left join olympics.dbo.noc_regions r on ae.NOC = r.NOC
where r.region = 'India' and Medal !='NA'
group by Sport 
order by count(Medal) desc;

select 
	Event,
	count(Medal) as medals
from olympics.dbo.athlete_events$ ae
left join olympics.dbo.noc_regions r on ae.NOC = r.NOC
where r.region = 'India' and Medal !='NA'
group by Event
order by count(Medal); 

--20. List all the games India won medal for Hockey. How many medals are there?
select 
	Games,
	count(Medal) as "Hockey medals"
from olympics.dbo.athlete_events$ ae
left join olympics.dbo.noc_regions r on ae.NOC = r.NOC
where Sport = 'Hockey' and region = 'India'
group by Games

