
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

# ------------------------------------------------------ #
# INDEXES

show indexes from customers;

create index last_name_idx
on customers(last_name);

select * from customers
where last_name = 'Ray';

select * from customers
where first_name = 'Man';

select *
from customers;

create index last_name_first_idx
on customers(last_name, first_name);

alter table customers
drop index last_name_first_idx;

show indexes from customers;

# ------------------------------------------------------ #
# SUBQUERY

select *
from transactions;

select
    first_name,
    last_name,
    hourly_pay,
    (select
            avg(hourly_pay)
        from employees) as avg_pay
from employees;

select
    first_name,
    last_name,
    hourly_pay
from employees
where hourly_pay > (select avg(hourly_pay) from employees);



select
    first_name,
    last_name
from customers
where customers_id in
    (select distinct
        customer_id
    from transactions
    where customer_id is not null);

# ------------------------------------------------------ #
# GROUP BY

alter table transactions
add column order_date date;

select *
from transactions;

update transactions
set order_date = '2023-01-03'
where transactions_id = 1002;


INSERT INTO transactions (amount, customer_id, order_date)
VALUES
    (50.75, 1, '2024-01-15'),
    (120.50, 2, '2024-02-20'),
    (30.00, 3, '2024-03-10'),
    (75.25, 2, '2024-03-12'),
    (10.00, 4, '2024-04-01'),
    (200.00, 5, '2024-04-15'),
    (99.99, 6, '2024-05-20'),
    (15.00, 7, '2024-06-05'),
    (300.00, 8, '2024-06-15'),
    (60.00, 9, '2024-07-10'),
    (45.75, 10, '2024-08-01'),
    (500.00, 11, '2024-08-20'),
    (250.00, 12, '2024-09-15'),
    (75.00, 1, '2024-02-01'),
    (180.25, 2, '2024-02-15'),
    (45.50, 3, '2024-03-05'),
    (500.00, 4, '2024-03-10'),
    (15.75, 5, '2024-04-12'),
    (220.00, 6, '2024-05-01'),
    (35.99, 7, '2024-05-15'),
    (125.50, 8, '2024-06-01'),
    (400.00, 9, '2024-06-20'),
    (75.25, 10, '2024-07-01'),
    (85.00, 11, '2024-07-10'),
    (300.75, 12, '2024-07-25'),
    (25.00, 1, '2024-08-01'),
    (99.99, 2, '2024-08-15'),
    (150.50, 3, '2024-08-20'),
    (175.75, 4, '2024-09-01'),
    (250.00, 5, '2024-09-10'),
    (30.00, 6, '2024-10-01'),
    (10.50, 7, '2024-10-10'),
    (450.75, 8, '2024-10-25'),
    (550.00, 9, '2024-11-05'),
    (75.00, 10, '2024-11-15'),
    (80.25, 11, '2024-11-25'),
    (95.00, 12, '2024-12-01'),
    (600.00, 1, '2024-12-10'),
    (300.50, 2, '2024-12-20'),
    (45.99, 3, '2024-12-25'),
    (20.00, 4, '2024-12-31'),
    (100.75, 5, '2025-01-01'),
    (75.50, 6, '2025-01-05'),
    (120.25, 7, '2025-01-10'),
    (400.00, 8, '2025-01-15'),
    (99.00, 9, '2025-01-20'),
    (200.50, 10, '2025-02-01'),
    (85.25, 11, '2025-02-10'),
    (150.00, 12, '2025-02-15'),
    (15.25, 1, '2024-01-05'),
    (8.50, 2, '2024-01-10'),
    (22.00, 3, '2024-01-15'),
    (12.75, 4, '2024-01-20'),
    (18.00, 5, '2024-01-25'),
    (7.99, 6, '2024-01-30'),
    (5.50, 7, '2024-02-01'),
    (9.75, 8, '2024-02-05'),
    (11.00, 9, '2024-02-10'),
    (10.25, 10, '2024-02-15'),
    (6.50, 11, '2024-02-20'),
    (14.75, 12, '2024-02-25'),
    (19.99, 1, '2024-03-01'),
    (20.00, 2, '2024-03-05'),
    (17.50, 3, '2024-03-10'),
    (12.00, 4, '2024-03-15'),
    (15.00, 5, '2024-03-20'),
    (9.25, 6, '2024-03-25'),
    (7.75, 7, '2024-04-01'),
    (8.00, 8, '2024-04-05'),
    (22.50, 9, '2024-04-10'),
    (11.75, 10, '2024-04-15'),
    (10.00, 11, '2024-04-20'),
    (25.00, 12, '2024-04-25'),
    (30.50, 1, '2024-05-01'),
    (35.75, 2, '2024-05-05'),
    (45.00, 3, '2024-05-10'),
    (50.00, 4, '2024-05-15'),
    (28.75, 5, '2024-05-20'),
    (33.25, 6, '2024-05-25'),
    (29.50, 7, '2024-06-01'),
    (26.75, 8, '2024-06-05'),
    (31.00, 9, '2024-06-10'),
    (40.25, 10, '2024-06-15'),
    (18.50, 11, '2024-06-20'),
    (22.75, 12, '2024-06-25'),
    (24.00, 1, '2024-07-01'),
    (10.50, 2, '2024-07-05'),
    (15.75, 3, '2024-07-10'),
    (20.00, 4, '2024-07-15'),
    (9.00, 5, '2024-07-20'),
    (7.25, 6, '2024-07-25'),
    (6.75, 7, '2024-08-01'),
    (12.50, 8, '2024-08-05'),
    (17.75, 9, '2024-08-10'),
    (11.25, 10, '2024-08-15'),
    (19.50, 11, '2024-08-20'),
    (23.00, 12, '2024-08-25');

select
    sum(amount),
    order_date
from transactions
group by order_date;

SELECT
    SUM(amount) AS total_amount,
    YEAR(order_date) AS year
FROM transactions
GROUP BY YEAR(order_date);

select
    first_name,
    count(amount)
from transactions
    inner join customers
on transactions.customer_id = customers.customers_id
group by first_name
having count(amount) >= 9;

# ------------------------------------------------------ #
# ROLLUP

select *
from transactions;

SELECT
    SUM(amount) AS total_amount,
    YEAR(order_date) AS year
FROM transactions
GROUP BY YEAR(order_date) with rollup;

select
    first_name,
    count(amount)
from transactions
    inner join customers
on transactions.customer_id = customers.customers_id
group by first_name with rollup;

# ------------------------------------------------------ #
# ON DELETE

-- ON DELETE SET NULL = When a FK is deleted, replace FK with NULL
-- ON DELETE CASCADE  = When a FK is deleted, replace FK with NULL

select *
from transactions;

alter table transactions
drop foreign key fk_customers_id;

alter table transactions
add constraint fk_customers_id
foreign key(customer_id) references customers(customers_id)
on delete set null;

alter table transactions
add constraint fk_customers_id
foreign key(customer_id) references customers(customers_id)
on delete cascade ;

delete from customers
where customers_id = 5;

# ------------------------------------------------------ #
# STORED PROCEDURES

delimiter $$
create procedure get_employees()
begin
    select * from employees;
end $$
delimiter ;

call get_employees();

delimiter $$
create procedure find_customers(in id int)
begin
    select *
    from customers
    where customers_id = id;
end $$
delimiter ;

call find_customers(11);

select *
from employees;

delimiter $$
create procedure find_employees(in f_name varchar(50), in l_name varchar(50))
begin
    select *
    from employees
    where first_name = f_name and last_name = l_name;
end $$
delimiter ;

call find_employees('Sandy', 'Cheeks');

select *
from employees;

# ------------------------------------------------------ #
# TRIGGERS

select *
from employees;

alter table employees
add column salary decimal(10, 2) after hourly_pay;

update employees
set salary = hourly_pay * 2080;

create trigger before_hourly_pay_update
before update on employees
for each row
set NEW.salary = (NEW.hourly_pay * 2080);

show triggers;

select *
from employees;

update employees
set hourly_pay = hourly_pay + 1;

delete
from employees
where employee_id = 8;

create trigger before_hourly_pay_insert
before insert on employees
for each row
set NEW.salary = (new.hourly_pay * 2080);


insert into employees (employee_id, first_name, last_name, hourly_pay, salary, job, hire_date, supervisor_id)
values (8,'Pearl', 'Krabs', 19.20, null, 'janitor', '2020-12-11', 5);

select *
from employees;

create table expenses(
    expense_id int primary key,
    expense_name varchar(50),
    expense_total decimal(10, 2)
);

insert into expenses
values (1, 'salaries', 0),
       (2, 'supplies', 0),
       (3, 'taxes', 0);

select *
from expenses;

update expenses
set expense_total = (select sum(salary) from employees)
where expense_name = 'salaries';

create trigger after_salary_delete
after delete on employees
for each row
update expenses
set expense_total = expense_total - OLD.salary
where expense_name = 'salaries';

# 1759160.00

delete from employees
where employee_id = 8;

# expense_total = 1719224.00

create trigger after_salary_insert
after insert on employees
for each row
update expenses
set expense_total = expense_total + NEW.salary
where expense_name = 'salaries';

insert into employees (employee_id, first_name, last_name, hourly_pay, salary, job, hire_date, supervisor_id)
values (8,'Pearl', 'Krabs', 19.20, null, 'janitor', '2020-12-11', 5);

# expense_total = 1759160.00

create trigger after_salary_update
after update on employees
for each row
update expenses
set expense_total = expense_total + (NEW.salary - OLD.salary)
where expense_name = 'salaries';


update employees
set hourly_pay = 100
where employee_id = 1;

select *
from employees;

select *
from expenses;

# expense_total = 1926600.00


