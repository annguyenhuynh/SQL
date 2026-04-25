create or replace procedure pr_sales_param(p_product_code varchar, p_quantity int)
language plpgsql
as $$
declare
	v_count int;
	v_product_code varchar(20);
	v_price numeric (12,2);

begin
	select count(*)
	into v_count
	from products
	where product_code = p_product_code
		and quantity_remaining >= p_quantity;

	if v_count > 0 then
		select product_code, price
		into v_product_code, v_price
		from products
		where product_code = p_product_code;

		insert into sales (
			order_date, 
			product_code,
			quantity_order,
			sales_price
		)
		values (
			current_date,
			v_product_code,
			p_quantity,
			v_price*p_quantity
		);

		update products
		set quantity_remaining = quantity_remaining - p_quantity,
			quantity_sold = quantity_sold + p_quantity
		where product_code = v_product_code;

		RAISE notice 'Product Sold';
	else
		raise notice 'Insufficient amount';
	end IF;
end;
$$;
	
			
