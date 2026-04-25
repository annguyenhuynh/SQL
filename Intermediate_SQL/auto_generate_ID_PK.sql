CREATE TABLE sales (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_date DATE NOT NULL,
    product_code VARCHAR(20) NOT NULL,
    quantity_order INT NOT NULL,
    sales_price NUMERIC(12,2) NOT NULL
);

