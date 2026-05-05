-- Find the product that constitute for 30% of data
select product_name, (dist_pct||'%') as cum_dis_pct
from(
select *,
cume_dist() over (order by price desc) as cumulative_distribution,
round(cume_dist() over(order by price desc)::numeric * 100,2) as dist_pct
from dev.product p) as x
where x.dist_pct <= 30;

-- Percent Rank
select *,
	round(percent_rank() over (order by price)::numeric * 100,2) as per_rnk
from dev.product p