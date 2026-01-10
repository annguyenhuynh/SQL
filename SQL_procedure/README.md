* 1. What is **Stored Procedure**?
* A stored procedure is a program that runs inside PostgreSQL.
	* Not just a query.
	* Not just SQL.
	* A program with:
	• Variables
	• IF statements
	• Loops
	• Transactions
	• Error handling
	• Logging
	• Return values

**Think of it as Python running inside your database engine**

* 2. Procedure Syntax

```sql
CREATE PROCEDURE name ( parameters )
LANGUAGE plpgsql
AS $$
DECLARE       -- optional
BEGIN         -- required
    -- logic
END;
$$;
```
* 3. How to add value to a new column in SQL
```
UPDATE procedure_dev.customers
SET score =
	CASE WHEN cst_marital_status = 'M' then 30 else 45 END
	+ CASE WHEN cst_gndr = 'F' then 40 ELSE 20 END
	+ CASE WHEN EXTRACT(year from cst_create_date) = 2025 THEN 40 ELSE 0 END;
```
* 4. Parameters (IN / OUT / INOUT)
| Type  | Meaning        |
| ----- | -------------- |
| IN    | Input value    |
| OUT   | Value returned |
| INOUT | Both           |

--> E.g.: (IN order_id INT, OUT total NUMERIC)
* Procedures **return values only through OUT parameters**.

* 5. Declare variables
* DECLARE is for **local variables** — like temp = 0 in Python.
--> 
	```sql
	DECLARE
    v_count INT,
    v_total NUMERIC := 0;
	```

* 6. BEGIN / END (Program Body)
| Feature               | Example                                     |
| --------------------- | ------------------------------------------- |
| Assign                | `v_total := 100;`                           |
| Query into variables  | `SELECT COUNT(*) INTO v_count FROM orders;` |
| Condition             | `IF v_count = 0 THEN ... END IF;`           |
| Loop                  | `FOR r IN SELECT ... LOOP ... END LOOP;`    |
| Call other procedures | `CALL load_batch();`                        |
| Transactions          | `COMMIT;`                                   |
| Errors                | `EXCEPTION WHEN OTHERS THEN ...`            |

* 7. Call Procedure
	* Basic Call
	```sql
	CALL procedure_dev.customer_summary('USA');
	```
	* CALL with OUT parameter
	```sql
	DO $$
	DECLARE
		v_total INT;
		V_avg NUMERIC;
	BEGIN
		CALL procedure_dev.customer_summary(v_total, v_avg);
		RAISE NOTICE 'Total=% Avg=%', v_total v_avg;
	END;
	$$;
	```

* 8. Why DO $$ Exists?
	* **DO** is a temporary anonymous procedure.
	* It lets you:
		• Declare variables
		• Capture OUT parameters
		• Add loops
		• Add error handling
		• Build batch runners
