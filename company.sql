create schema company_resources;

create table company_resources.employees_table(
    employee_id VARCHAR(10) primary key,
	first_name VARCHAR(50) not null,
	last_name VARCHAR(50) not null,
	gender VARCHAR(15) not null,
	department VARCHAR(50),
	hire_date DATE not null,
	salary FLOAT 
);

insert into company_resources.employees_table(employee_id, first_name, last_name,gender,department, hire_date, salary)
values 
(1,'Jhon','Doe','Male','IT','2018-05-01',60000.00),
(2,'Jane','Smith','Female','HR','2019-06-15',50000.00),
(3,'Michale','Johnson','Male','Finance','2017-03-10',75000.00),
(4,'Emily','Davis','Female','IT','2020-11-20',70000.00),
(5,'Sarah','Brown','Femlae','Marketing','2016-07-30',45000.00),
(6,'David','Wilson','Male','Sales','2019-01-05',55000.00),
(7,'Chris','Taylor','Male','IT','2022-02-25',65000.00);

CREATE TABLE company_resources.products_table (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    catagory VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);
insert into company_resources.products_table (product_id,product_name,catagory,price,stock)
values(1,'Laptop','Electronics',1200.00,30),
(2,'Desk','Furniture',300.00,50),
(3,'Chair','Furniture',150.00,200),
(4,'Smartphone','Electronics',800.00,75),
(5,'Monitor','Electronics',250.00,40),
(6,'Bookshelf','Furniture',100.00,60),
(7,'Printer','Electronics',200.00,25);


create table  company_resources.sales_table (
sales_id INT primary key,
product_id INT references  company_resources.products_table(product_id),
employee_id VARCHAR(50) references  company_resources.employees_table(employee_id),
sales_date DATE not null,
quantity INT not null,
total decimal(8,2)
);
insert into  company_resources.sales_table(sales_id, product_id,employee_id, sales_date, quantity, total)
values
(1,1,1,'2021-01-15',2,2400.00),
(2,2,2,'2021-03-22',1,300.00),
(3,3,3,'2021-05-10',4,2400.00),
(4,4,4,'2021-07-18',3,2400.00),
(5,5,5,'2021-09-25',2,500.00),
(6,6,6,'2021-11-30',1,100.00),
(7,7,1,'2021-05-10',1,200.00),
(8,1,2,'2021-05-10',1,1200.00),
(9,2,3,'2021-05-10',2,600.00),
(10,3,4,'2021-05-10',3,450.00),
(11,4,5,'2021-05-10',1,800.00),
(12,5,6,'2021-05-10',4,1000.00);

update company_resources.employees_table
set gender='Female'
where first_name='Sarah';

--1
select * from company_resources.employees_table;
--2
select employees_table.first_name
from company_resources.employees_table;
--3
select employees_table.first_name,last_name
from company_resources.employees_table
where department='IT';
--4
select distinct employees_table.department
from company_resources.employees_table ;
--5
select count (*) as total_employees
from company_resources.employees_table;
--6
select SUM(salary)
from company_resources.employees_table;
--7
select AVG(salary)
from company_resources.employees_table;
--8
select MAX(salary)
from company_resources.employees_table;
--9
select MIN(salary)
from company_resources.employees_table;
--10
select count (*) as male_employees
from company_resources.employees_table
where gender='Male';
--11
select count (*) as female_employees
from company_resources.employees_table
where gender='Female';
--12
select count (*) as employees_hired_in_2020
from company_resources.employees_table
where EXTRACT(YEAR from hire_date)=2020;
--13
select AVG(salary)
from company_resources.employees_table
where department='IT';
--14
select employees_table.department, count (*) as employees_in_each_department
from company_resources.employees_table
group by department;
--15
select employees_table.department, sum (salary) as total_salary_in_department
from company_resources.employees_table
group by department;
--16
select employees_table.department, max (salary) as maximum_salary_in_department
from company_resources.employees_table
group by department;
--17
select employees_table.department, min (salary) as maximum_salary_in_department
from company_resources.employees_table
group by department;
--18
select employees_table.gender,count (*) as total_employee_gender_group
from company_resources.employees_table
group by gender;
--19
select employees_table.gender,avg (salary) as total_employee_gender_group
from company_resources.employees_table
group by gender;
--20
SELECT * FROM company_resources.employees_table ORDER BY salary DESC LIMIT 5;
--21
SELECT COUNT(DISTINCT first_name)
FROM company_resources.employees_table;

SELECT 
    employees_table.employee_id,
    employees_table.first_name,
    employees_table.last_name,
    sales_table.sales_id,
    sales_table.total
FROM 
    company_resources.employees_table 
LEFT JOIN 
    company_resources.sales_table 
ON 
    employees_table.employee_id = sales_table.employee_id;
--22
SELECT * FROM  company_resources.employees_table
ORDER BY hire_date ASC
LIMIT 10;
--23
SELECT * FROM company_resources.employees_table 
WHERE NOT EXISTS (
	SELECT 1 FROM company_resources.sales_table WHERE sales_table.employee_id = employees_table.employee_id
);
--24
SELECT e.employee_id, e.first_name, e.last_name, COUNT(s.employee_id) AS total_sales
FROM company_resources.employees_table e, company_resources.sales_table s
where e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;
--25
SELECT e.employee_id, e.first_name, e.last_name, SUM(s.total) AS total_sales
FROM company_resources.employees_table e, company_resources.sales_table s
WHERE e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC
LIMIT 1;
--26
select  e.department, avg(s.quantity) as average_quantity
from company_resources.sales_table  s, company_resources.employees_table  e
where e.employee_id=s.employee_id
group by e.department;
--27
select s.employee_id, s.sales_date
from company_resources.sales_table s
where sales_date between '2020-12-31' and '2022-1-1';
--28
SELECT s.employee_id, e.first_name, e.last_name, SUM(s.quantity) AS total_quantity
FROM
  company_resources.sales_table s, company_resources.employees_table e
where s.employee_id = e.employee_id
GROUP BY s.employee_id, e.first_name, e.last_name
ORDER by total_quantity DESC
LIMIT 3;
--29
select e.department, SUM(s.quantity) AS total_quantity
from company_resources.sales_table s, company_resources.employees_table e
group by e.department;
--30
select p.catagory, sum(s.total) as revenue
from company_resources.products_table p, company_resources.sales_table s
group by p.catagory;













