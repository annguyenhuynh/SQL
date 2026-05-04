* 🥇 first_value(): windows function that returned first value from an ordered set of data. It is commonly used to find the earliest, the cheapest, the top record relative to other rows in the set of data

```
FIRST_VALUE(column_name) OVER (
    [PARTITION BY partition_column]
    ORDER BY sort_column [ASC | DESC]
)
```
➡ E.g: You want to find the most expensive product in each product category
```
select 
	p.*,
	first_value(product_name) over(partition by product_category order by price desc) as most_expensive_product
from product p
```
![alt text](image.png)

*  Frame clause:
  * **range|rows|groups between {start_bound} and {end_bound}**

  * ⿴ Bounded keywords:
    - UNBOUNDED PRECEDING: The very first row of the partition.
    - UNBOUNDED FOLLOWING: The very last row of the partition.CURRENT 
    - ROW: The row being currently processed.
    - N PRECEDING / N FOLLOWING: Exactly \(n\) rows before or after the current row