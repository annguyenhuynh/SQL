-- Add popularity column based on total
SELECT 
	gender,
	name,
	total,
	ROW_NUMBER() OVER (ORDER BY total DESC) as popularity
FROM babynames;

-- Compare different ranking functions
SELECT 
	gender,
	name,
	total,
	ROW_NUMBER() OVER (ORDER BY total DESC) as popularity,
	RANK() OVER (ORDER BY total DESC) as popularity_r,
	DENSE_RANK() OVER (ORDER BY total DESC) as popularity_dr
	
FROM babynames;

-- Popular names by gender
SELECT * FROM 
(
SELECT 
	gender,
	name,
	total,
	DENSE_RANK() OVER (PARTITION BY gender ORDER BY total DESC) as popularity
FROM babynames) AS pop
WHERE popularity <= 3