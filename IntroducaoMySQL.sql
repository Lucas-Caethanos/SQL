
create database myDB;

use myDB;

# alter database myDB READ only = 0;

drop database myDB;

# ------------------------------------------------------ #
# TABLES

create table employees(
    employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    hourly_pay decimal(5, 2),
    hire_date date
);

select * from employees;

rename table employees to workes;

select * from workes;

rename table workes to employees;

select * from employees;

alter table employees
add phone_number varchar(15);

alter table employees
rename column phone_number to email;

alter table employees
modify column email varchar(100);

alter table employees
modify email varchar(100)
after last_name;

alter table employees
drop column email;

# ------------------------------------------------------ #
# INSERT ROWS

select * from employees;

insert into employees
values
(1, 'SpongeBob', 'SquarePants', 18.50, '2020-05-01'),
(2, 'Patrick', 'Star', 15.00, '2021-07-15'),
(3, 'Squidward', 'Tentacles', 22.00, '2019-11-20'),
(4, 'Sandy', 'Cheeks', 30.00, '2022-03-10'),
(5, 'Mr.', 'Krabs', 35.50, '2018-06-25'),
(6, 'Plankton', 'Sheldon', 12.75, '2023-01-05'),
(7, 'Karen', 'Plankton', 25.00, '2021-09-17'),
(8, 'Pearl', 'Krabs', 19.20, '2020-12-11'),
(9, 'Gary', 'Snail', 10.00, '2019-08-30'),
(10, 'Mermaid', 'Man', 28.50, '2022-11-22');

insert into employees (employee_id, first_name, last_name)
values
    (11, 'Barnacle', 'Boy');

# ------------------------------------------------------ #
# SELECT

select * from employees;

select
    first_name,
    last_name
from employees;

select *
from employees
where employee_id = 4;

select *
from employees
where first_name = 'Plankton';

select *
from employees
where hire_date <= '2021-01-03';

select *
from employees
where employee_id != 4;

select *
from employees
where hire_date is null;

select *
from employees
where hire_date is not null;

# ------------------------------------------------------ #
# UPDATE & DELETE

update employees
set hourly_pay = 10.25,
    hire_date = '2023-01-07'
where employee_id = 11;

delete from employees
where employee_id = 11;

# ------------------------------------------------------ #
# AUTOCOMMIT, COMMIT, ROLLBACK

set autocommit = off;

commit;

select *
from employees;

delete from employees;

rollback;

select *
from employees;

set autocommit = on;

# ------------------------------------------------------ #
# CURRENT_DATE() & CURRENT_TIME()

create table test(
    my_date DATE,
    my_time TIME,
    my_datetime DATETIME
);

select * from test;

insert into test
values (current_date(), current_time(), now());

drop table test;

# ------------------------------------------------------ #
# UNIQUE

create table products (
    product_id INT,
    product_name VARCHAR(25) unique,
    price DECIMAL(4, 2)
);

select *
from products;

alter table products
add constraint
unique(product_name);

insert into products
values
    (100, 'hamburger', 3.999),
    (101, 'fries', 1.89),
    (102, 'soda', 1.00),
    (103, 'ice cream', 1.49);

# ------------------------------------------------------ #
# NOT NULL

select * from products;

alter table products
modify price DECIMAL(4, 2) not null;

insert into products
values
    (104, 'cookie', null);


# ------------------------------------------------------ #
# CHECK

select * from employees;

alter table employees
add constraint chk_hourly_pay check (hourly_pay >= 1.00);

insert into employees (employee_id, first_name, last_name, hourly_pay, hire_date)
values
    (12, 'Barnacle', 'Boy', 2.00, '2021-11-03');

alter table employees
drop check chk_hourly_pay;

# ------------------------------------------------------ #
# DEFAULT

select *
from products;

insert into products
values
    (104, 'straw', 0.00),
    (105, 'napkin', 0.00),
    (106, 'fork', 0.00),
    (107, 'spoon', 0.00);

delete from products
where product_id >= 104;

alter table products
alter price set default 0;

insert into products (product_id, product_name)
values
    (104, 'straw'),
    (105, 'napkin'),
    (106, 'fork'),
    (107, 'spoon');

# ------------------------------------------------------ #
# PRIMARY KEYS













