drop table if exists interview.billing;

create table interview.billing (
customer_id integer,
customer_name varchar,
billing_id varchar,
billing_creation_date date,
billing_amount integer
);

insert into interview.billing (customer_id,customer_name,billing_id,billing_creation_date,billing_amount)
values
(1, 'A', 'id1', '10-10-2020', 100),
(1, 'A', 'id2', '11-11-2020', 150),
(1, 'A', 'id3', '12-11-2021', 100),
(2, 'B', 'id4', '10-11-2019', 150),
(2, 'B', 'id5', '11-11-2020', 200),
(2, 'B', 'id6', '12-11-2021', 250),
(3, 'C', 'id7', '01-01-2018', 100),
(3, 'C', 'id8', '05-01-2019', 250),
(3, 'C', 'id9', '06-01-2021', 300)
;

select * from interview.billing;

--Display average amount of billing for each customer between 2019 and 2021, 
--assuming $0 if nothing is billed in that period