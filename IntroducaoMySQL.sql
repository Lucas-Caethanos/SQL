
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

alter table employees
add constraint
PRIMARY KEY(employee_id);

insert into employees (employee_id, first_name, last_name, hourly_pay, hire_date)
values
    (11, 'Barnacle', 'Boy', 2.00, '2021-11-03');

# Duplicate entry '11' for key 'employees.PRIMARY'
# Column 'employee_id' cannot be null

# ------------------------------------------------------ #
# AUTO_INCREMENT

ALTER TABLE employees
MODIFY employee_id INT AUTO_INCREMENT;

delete from employees
where employee_id = 14;

INSERT INTO employees (employee_id, first_name, last_name, hourly_pay, hire_date)
VALUES
(11, 'Barnacle', 'Boy', 24.00, '2021-02-10'),
(12, 'Larry', 'Lobster', 26.75, '2020-04-15'),
(13, 'Bubble', 'Bass', 20.50, '2021-12-05'),
(14, 'Flying', 'Dutchman', 40.00, '2018-10-13');

ALTER TABLE employees AUTO_INCREMENT = 11;

select *
from employees;

insert into employees (first_name, last_name, hourly_pay, hire_date)
values
    ('Mrs.', 'Puff', 22.80, '2019-03-17');

insert into employees (first_name, last_name, hourly_pay, hire_date)
values
    ('Fred', 'MyLeg', 18.25, '2020-06-18');

# ------------------------------------------------------ #
# FOREIGN KEY

select *
from customers;

create table customers(
    customers_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

insert into customers (first_name, last_name)
values ('Old', 'Man Jenkins'),
       ('Doodle', 'Bob'),
       ('Patchy', 'Pirate'),
       ('Potty', 'Parrot'),
       ('Man', 'Ray'),
       ('Dirty', 'Bubble'),
       ('Bubble', 'Buddy'),
       ('Kevin', 'Cucumber'),
       ('Nat', 'Peterson'),
       ('Tom', 'Fish'),
       ('Nancy', 'SuzyFish'),
       ('Scooter', 'SurfFish');


create table transactions(
    transactions_id INT PRIMARY KEY auto_increment,
    amount DECIMAL(5, 2),
    customer_id INT,
    foreign key(customer_id) references customers(customers_id)
);

ALTER TABLE transactions AUTO_INCREMENT = 1000;

insert into transactions (amount, customer_id)
values
    (4.99, 3),
    (2.89, 2),
    (3.38, 3),
    (4.99, 1);

select *
from transactions;

insert into transactions (amount, customer_id)
values
    (1.99, NULL);

# ------------------------------------------------------ #
# JOINS KEY


select *
from transactions inner join customers
on transactions.customer_id = customers.customers_id;

select *
from transactions right join customers
on transactions.customer_id = customers.customers_id;


select *
from transactions left join customers
on transactions.customer_id = customers.customers_id;

# ------------------------------------------------------ #
# FUNCTIONS

select
    count(amount) as count,
    max(amount) as maximum,
    min(amount) as minimum,
    avg(amount) as average,
    sum(amount) as sum
from transactions;

select
    concat(first_name, ' ', last_name) as full_name
from employees;

# ------------------------------------------------------ #
# AND, OR, NOT

alter table employees
add column  job varchar(25) after hourly_pay;

select *
from employees;

update employees
set job = 'janitor'
where employee_id = 6;

select *
from employees
where hire_date < '2023-01-05' and job = 'cook';


select *
from employees
where job = 'cook' or job = 'cashier';

select *
from employees
where not job = 'manager';

select *
from employees
where job in ('manager', 'cashier', 'janitor');

# ------------------------------------------------------ #
# WILD CARDS

select *
from employees
where first_name like 's%';

select *
from employees
where last_name like '%r';

select *
from employees
where job like '_ook';

select *
from employees
where hire_date like '____-06-__';

select *
from employees
where job like '_a%';

# ------------------------------------------------------ #
# ORDER BY

select *
from employees
order by last_name;

select *
from employees
order by last_name desc;

select *
from transactions
order by amount, customer_id;

# ------------------------------------------------------ #
# LIMIT

select *
from customers
order by last_name
limit 4;

select *
from customers
limit 3, 1;

# ------------------------------------------------------ #
# UNIONS - combines the results of two or more SELECT statements

select
    first_name,
    last_name
from employees
union
select
    first_name,
    last_name
from customers;

select
    first_name,
    last_name
from employees
union all
select
    first_name,
    last_name
from customers;

# ------------------------------------------------------ #
# SELF JOINS

alter table customers
add referral_id int;

select * from customers;

update customers
set referral_id = 2
where customers_id = 4;

select
    a.customers_id,
    a.first_name,
    a.last_name,
    concat(b.first_name, ' ', b.last_name)  as 'referred_by'
from customers as a
inner join customers as b
on a.referral_id = b.customers_id;

select * from employees;

alter table employees
add supervisor_id int;

update employees
set supervisor_id = 5
where employee_id = 4;

select
    a.employee_id,
    a.first_name,
    a.last_name,
    concat(b.first_name, ' ', b.last_name) as 'supervisor'
from employees as a
inner join employees as b
on a.supervisor_id = b.employee_id;

# ------------------------------------------------------ #
# VIEWS

create view employee_attendance as
select
    first_name,
    last_name
from employees;

select *
from employee_attendance
order by last_name;

drop view employee_attendance;

alter table customers
add column email varchar(50);

select *
from customers;

UPDATE customers
SET email = 'old.man.jenkins@exemplo.com'
WHERE customers_id = 1;

alter table customers
drop column email;

update customers
set email = lower(
                concat_ws('.',
                replace(first_name, ' ', '-'),
                replace(last_name, ' ', '-'),
                '@email.com')
            )
where email is null or email = '';

select *
from customers;

create view customers_emails as
select
    email
from customers;


