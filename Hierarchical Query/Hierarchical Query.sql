-- Hierarchical query
-- For this, we will use oracle HR schema to run queries and understand the behaviour

-- view the employees table data
select * from employees;

-- display employee name, employee id and employee's manager name and manager id and level
-- PRIOR is a unary operator which is used or indicates that "father of" the records or first records
-- START WITH clause is used to find out from which record user needs to start hierarchy, In the below example
-- LEVEL is pseudo column which gives the depth of hierarchy
-- CONNECT BY gives idea about siblings with specified condition
select first_name||' '||last_name, employee_id, prior first_name||' '||prior last_name, manager_id, level
from employees
connect by prior employee_id=manager_id
start with manager_id is null
order by level;

--Show records in heirarchical structure
select lpad(' ',level*5,' ')||first_name||' '||last_name as Employee_Name, employee_id, prior first_name||' '||prior last_name as Manager_Name, manager_id, level
from employees
connect by prior employee_id=manager_id
start with manager_id is null
order by level;

-- NO CYCLE in case where cyclic dependency is present then using this, creation of hierarchy can be avoided 
create table employee_test as
select * from employees;

select * from employee_test;

update employee_test set manager_id=100 where employee_id=100;

commit;

-- Below query will result in error
select lpad(' ',level*5,' ')||first_name||' '||last_name, employee_id, prior first_name||' '||prior last_name as Manager_Name, manager_id, level
from employee_test
connect by prior employee_id=manager_id
start with manager_id=100
order by level;

-- To avoid it, use NOCYCLE clause
select lpad(' ',level*5,' ')||first_name||' '||last_name, employee_id, prior first_name||' '||prior last_name as Manager_Name, manager_id, level
from employee_test
connect by nocycle prior employee_id=manager_id
start with manager_id=100
order by level;

drop table employee_test;

-- CONNECT_BY_ROOT unary operator which gives idea about the root of hierarchy
-- Query to get details in tree format
select lpad(' ',level*3,' ')||first_name||' '||last_name as name,connect_by_root first_name||' '||last_name as boss
from employees
connect by prior employee_id=manager_id
start with manager_id is null;

-- Query to see employee boss details
--SYS_CONNECT_BY_PATH(COLUMN_NAME,DELIMITER)
select lpad(' ',level*3,' ')||first_name||' '||last_name as name, sys_connect_by_path(first_name||' '||last_name,'/') as boss
from employees
connect by prior employee_id=manager_id
start with manager_id is null;

