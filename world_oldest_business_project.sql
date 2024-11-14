-- The oldest business in the world
SELECT min(year_founded) as earliest_year, max(year_founded) as latest_year
FROM businesses;

-- How many business were founded before 1000
SELECT count(distinct(business)) as business
FROM businesses
where year_founded < 1000;

-- Which businesses were found before 1000?
SELECT b.business,c.category 
FROM businesses b
JOIN categories c
ON b.category_code = c.category_code
WHERE b.year_founded <1000;

-- Which business category is the most common
SELECT c.category, count(b.category_code) as n 
from businesses b
join categories c on b.category_code = c.category_code
GROUP by c.category 
ORDER by count(b.category_code) desc;

-- Which continent has the oldest busines?
SELECT co.continent, b.business, c.category, b.year_founded
FROM countries co
JOIN businesses b ON co.country_code = b.country_code 
JOIN categories c ON b.category_code = c.category_code 
WHERE b.year_founded = (SELECT min(year_founded) from businesses);

-- Count categories by continent 
SELECT co.continent, count(b.category_code) as n 
FROM countries co
JOIN businesses b ON co.country_code = b.country_code 
GROUP by 1;

-- Find the categories from each continent that has more than 5 business
SELECT co.continent, c.category, COUNT(b.business) as n
FROM countries co
JOIN businesses b ON co.country_code = b.country_code
JOIN categories c ON b.category_code = c.category_code 
GROUP BY co.continent, c.category
HAVING COUNT(b.business) > 5
ORDER BY n DESC;




