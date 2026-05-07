#### PROBLEM 1: Successful Purchase 

### PROBLEM 2: Total of latest order 
* Can use cte to find the latest order date and join with orders table
* Or use left join with subquery to match the latest order date with the order date in the orders table
* Using **COALESCE** function to substitute for values with no matching data in table 

#### PROBLEM 3: Finding total orders of past active customers
* Use **FILTER (WHERE <condition>) with GROUP BY and HAVING for filtering, and checking existing condition in the dataset
* Use **CASE WHEN** like **if...else** in programming. This is mainly used for aggregations with conditions
