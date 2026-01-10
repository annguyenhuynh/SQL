-- Step 1: Write a query
SELECT  
	COUNT(*) AS TotalCustomers,
	AVG(score) AS AverageScore
FROM procedure_dev.customers
WHERE country = 'USA'

-- Step 2: Turn the query into a Stored Procedure
CREATE OR REPLACE PROCEDURE procedure_dev.customer_summary (
	OUT total_customers INTEGER,
	OUT avg_score NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT 
		COUNT(*),
		AVG(score)
	INTO 
		total_customers,
		avg_score
	FROM procedure_dev.customers
WHERE country = 'USA';
END;
$$;

-- Basic Call
-- Why NULL value? Because you declare OUT parameters in the procedure
CALL procedure_dev.customer_summary(NULL, NULL)

-- Proper way to call with parameters
DO $$
DECLARE 
 	v_total INT;
	v_avg NUMERIC;
BEGIN
	CALL procedure_dev.customer_summary(v_total, v_avg);
	RAISE NOTICE 'Total=% Avg=%', v_total, v_avg;
END;
$$;

