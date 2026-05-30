--Problem 1: Find the customer with multiple succesful purchases in the last 1 month. 
-- Purchases are considered successful if they are not returned within 1 week of purchase
SELECT c.id
FROM practice.customers c
JOIN practice.purchases p ON c.id = p.customer_id
WHERE p.purchase_date >=  
	(SELECT MAX(purchase_date) - INTERVAL '1 month'
    FROM practice.purchases)
  AND (
        p.return_date IS NULL
        OR p.return_date >= p.purchase_date + INTERVAL '1 week'
      )
GROUP BY c.id
having count(*) > 1