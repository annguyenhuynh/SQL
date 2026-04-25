CREATE OR REPLACE procedure pr_sales()
LANGUAGE plpgsql
AS $$
DECLARE
	v_product_code VARCHAR(20);
	v_price float;
BEGIN 
	SELECT product_code,price
	INTO v_product_code, v_price
	FROM products
	WHERE product_name = 'iPhone 13 Pro Max';

	if v_product_code is null
		THEN raise exception 'Product Not Found';
	end IF;

	insert into sales(
		order_date,
        product_code,
        quantity_order,
        sales_price
    )
    values (
        current_date,
        v_product_code,
        1,
        v_price
    );

	update products
	set 
		quantity_remaining = quantity_remaining-1,
		quantity_sold = quantity_sold + 1
		where product_code = v_product_code;
	
		RAISE notice 'Product Sold';
end;
$$;