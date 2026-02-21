-- PostgreSQL Practice --


-- To create table
create table learners (
id serial primary key,
name varchar(30) not null,
age int not null,
email varchar(30) unique,
salary decimal(10,2),
batch varchar(10)
);

-- To view the table
select * from learners;

-- To change column name
alter table learners
rename column batch to branch;

-- To change datatype of any column
alter table learners
alter column branch type blob;

-- To set a column not null
alter table learners
alter column branch set not null;

-- To delete one column
alter table learners
drop column branch;

-- To add one more column
alter table learners
add column dept varchar(20) not null;

-- To change table name
alter table learners
rename to employees;

-- To view the table
select * from employees;

-- To set a default value for a column
alter table employees
alter column salary set default 18000;

-- To insert data one by one
insert into employees(id, name, age, email, salary, dept)
values (1, 'Debarghya', 21, 'debarghya@gmail.com', 25000, 'DevOps');

insert into employees(id, name, age, email, salary, dept)
values (2, 'Aniket', 23, 'aniket@gmail.com', 20000, 'Design');

-- To insert multiple data at once
insert into employees(id, name, age, email, salary, dept)
values (3, 'Gourav', 20, 'gourav@yahoo.com', 21000, 'RAS'), 
(4, 'Shuvam', 24, 'shuvam@hotmail.com', 23000, 'Development'), 
(5, 'Sahil', 25, 'sahil@yahoo.com', 22000, 'Testing'),
(6, 'Rohit', 22, 'rohit@gmail.com', 22000, 'Marketing');

-- To update salary for any particular emp id
update employees set salary = 24000.00 where id = 5;

-- To delete record for any particular emp id
delete from employees
where id = 3;

-- To view distinct records of the table
select distinct salary as sal from employees;

-- To check conditions using AND, OR
select * from employees where id = '5' and name = 'Gourav';

select * from employees where id = '5' or name = 'Gourav';

-- To check between multivalues using IN and NOT IN
select * from employees
where salary in (21000, 24000);

select * from employees
where salary not in (21000, 24000);

-- To check between multivalues using BETWEEN and IN BETWEEN
select * from employees
where salary between 21000 and 24000;

select * from employees
where salary not between 21000 and 24000;

-- To limit records with and leave first one
select * from employees limit 4 offset 1;

-- To view records using LIKE and Wild Card
select * from employees
where name like 'A%';

select * from employees
where name like '_o%';

select * from employees
where name like '%h__';

-- To sort records by ascending order
select * from employees order by age; -- by default ascending

select * from employees order by age asc; -- for ascending

-- To sort records by descending order
select * from employees order by salary desc; -- for discending

-- To concat records with alias using concat()
select concat(name, '-', email) as name_with_email from employees;

-- To find length of any column using length()
select name, length(name) as name_length from employees;

-- To count the total records using count()
select count(*) from employees;

-- To find sum of all records using sum()
select sum(salary) as sum_salary from employees;

-- To find average of all records using avg()
select avg(salary) as avg_salary from employees;

-- To round off average salary on total records using round()
select round(avg(salary), 2) as round_avg_salary from employees;

-- To find maximum of any column using max()
select max(salary) as max_salary from employees;

-- To find minimum of any column using min()
select min(salary) as min_salary from employees;

-- To get total number of employees as per group using GROUP BY
select dept, count(*) from employees group by dept;

-- To get total number of employees in ascending order as per group
select dept, count(*) from employees group by dept order by dept;

-- To use having clause instead of where clause
select dept, avg(salary) from employees
group by dept
having avg(salary) > 30000
order by dept;

-- To get second highest salary using Sub Query
select max(salary) as second_highest_salary from employees 
where salary < (select max(salary) from employees);

-- To get third lowest salary using Sub Query
select min(salary) as third_lowest_salary from employees 
where salary > (select min(salary) from employees
where salary > (select min(salary) from employees));

-- To delete the whole data but not the table
delete from employees;

-- To delete the table
drop table if exists employees;


-- Joins -> Inner, Left, Right, Outer, Cross, Self
create table employee (
empid serial primary key,
empname varchar(30) not null,
empage int not null,
email varchar(30) unique,
salary decimal(10,2),
deptid varchar(10) unique not null
);

create table department (
deptid varchar(10) primary key,
deptname varchar(30) not null,
cabinid varchar(20) unique not null
);

create table cabin (
cabinid varchar(20) primary key,
cfloor int not null
);

-- To view all the tables
select * from employee;
select * from department;
select * from cabin;

-- To insert data into all the tables
insert into employee(empid, empname, empage, email, salary, deptid)
values (1, 'Debarghya', 21, 'debarghya@gmail.com', 26000, 'A01'), 
(2, 'Aniket', 23, 'aniket@gmail.com', 22000, 'A02'),
(3, 'Prantik', 22, 'prantik@yahoo.com', 21000, 'A03'),
(4, 'Sumit', 25, 'sumit@outlook.com', 24000, 'B01'),
(5, 'Rahul', 24, 'rahul@gmail.com', 23000, 'B02'),
(6, 'Kingkar', 26, 'kingkar@outlook.com', 25000, 'B03');

insert into department(deptid, deptname, cabinid)
values ('A01', 'Testing', '52HBC'), 
('A02', 'Design', '51TBL'),
('A03', 'RAS', '47DQY'),
('B01', 'Development', '58JFE'),
('B02', 'Documentation', '45PXI'),
('B03', 'Maintanence', '62VPN');

insert into cabin(cabinid, cfloor)
values ('52HBC', 3), 
('51TBL', 3),
('47DQY', 2),
('58JFE', 3),
('45PXI', 2),
('62VPN', 4);

-- To add foreign key into the created table
alter table employee add foreign key(deptid) references department(deptid);

alter table department add foreign key(cabinid) references cabin(cabinid);

-- Inner Join
select e.empid, e.empname, e.salary, e.deptid, d.deptname 
from employee e inner join department d
on e.deptid = d.deptid;

-- Left Join
select e.empid, e.empname, e.salary, e.deptid, d.deptname 
from employee e left join department d
on e.deptid = d.deptid;

-- Right Join
select e.empid, e.empname, e.salary, e.deptid, d.deptname 
from employee e right join department d
on e.deptid = d.deptid;

-- Full Outer Join
select e.empid, e.empname, e.salary, e.deptid, d.deptname 
from employee e full outer join department d
on e.deptid = d.deptid;

-- Cross Join
select e.empid, e.empname, e.salary, e.deptid, d.deptname 
from employee e cross join department d;

-- Self Join
select e1.empname, e2.deptid
from employee e1 join employee e2
on e1.deptid = e2.deptid;

-- Join with 3 tables - employee, department, cabin
select e.empid, e.empname, d.deptid, d.deptname, c.cabinid, c.cfloor
from employee e
join department d
on e.deptid = d.deptid
join cabin c
on d.cabinid = c.cabinid;
