Introduction to REF CURSOR

* A REF CURSOR is basically a data type.  
* A variable created based on such a data type is generally called a cursor variable.  
* A cursor variable can be associated with different queries at run-time.  
* The primary advantage of using cursor variables is their capability to pass result sets between sub programs (like stored procedures, functions, packages etc.).  

Let us start with a small sub-program as follows:
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  en emp.ename%type;
begin
  open c_emp for select ename from emp;
  loop
      fetch c_emp into en;
      exit when c_emp%notfound;
      dbms_output.put_line(en);
  end loop;
  close c_emp;
end;
```

Let us understand step by step. 

First statement you need to understand:  
```sql
type r_cursor is REF CURSOR;
```
The above statement simply defines a new data type called "r_cursor," which is of the type REF CURSOR. We declare a cursor variable named "c_emp" based on the type "r_cursor" as follows:
```sql
 c_emp r_cursor;
```
Every cursor variable must be opened with an associated SELECT statement as follows:
```sql
open c_emp for select ename from emp;
```
To retrieve each row of information from the cursor, I used a loop together with a FETCH statement as follows:  
```sql
  loop
      fetch c_emp into en;
      exit when c_emp%notfound;
      dbms_output.put_line(en);
  end loop;
```

Finally closed the cursor using the following statement:  
```sql
close c_emp;
```

%ROWTYPE with REF CURSOR  
In the previous section, I retrieved only one column (ename) using REF CURSOR.  Now I would like to retrieve more than one column (or entire row) of information using the same.  Let us consider the following example:
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  er emp%rowtype;
begin
  open c_emp for select * from emp;
  loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.ename || ' - ' || er.sal);
end loop;
  close c_emp;
end;
```
In the above example, the only crucial declaration is the following:
```sql
er emp%rowtype;
```
The above declares a variable named "er," which can hold an entire row from the "emp" table.  To retrieve the values (of each column) from that variable, we use the dot notation as follows:
```sql
dbms_output.put_line(er.ename || ' - ' || er.sal);
```

Let us consider that a table contains forty columns and I would like to retrieve fifteen columns.  In such scenarios, it is a bad idea to retrieve all forty columns of information.  At the same time, declaring and working with fifteen variables would be bit clumsy.  The next section will explain how to solve such issues.

Until now, we have been working either with %TYPE or %ROWTYPE. This means we are working with either one value or one complete record. How do we create our own data type, with our own specified number of values to hold? This is where TYPE and RECORD comes in.  Let us consider the following example:
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
  er rec_emp;
begin
  open c_emp for select ename,sal from emp;
  loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
  end loop;
  close c_emp;
end;
```

The most confusing aspect from the above program is the following:
```sql
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
```
The above defines a new data type named "rec_emp" (just like %ROWTYPE with limited specified fields) which can hold two fields, namely "name" and "sal."
```sql
  er rec_emp;
```
The above statement declares a variable "er" based on the datatype "rec_emp."  This means that "er" internally contains the fields "name" and "job."
```sql
  fetch c_emp into er;
```
The above statement pulls out a row of information (in this case "ename" and "sal") and places the same into the fields "name" and "sal" of the variable "er."  Finally, I display both of those values using the following statement:
```sql
  dbms_output.put_line(er.name || ' - ' || er.sal);
```
As defined earlier, a REF CURSOR can be associated with more than one SELECT statement at run-time.  Before associating a new SELECT statement, we need to close the CURSOR.  Let us have an example as follows:
```sql
 declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
  er rec_emp;
 begin
  open c_emp for select ename,sal from emp where deptno = 10;
  dbms_output.put_line('Department: 10');
  dbms_output.put_line('--------------');
  loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
  end loop;
  close c_emp;
  open c_emp for select ename,sal from emp where deptno = 20;
  dbms_output.put_line('Department: 20');
  dbms_output.put_line('--------------');
  loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
  end loop;
  close c_emp;
end;
```

In the above program, the skeleton looks like the following:
```sql
declare
.
.
Begin
.
.
  open c_emp for select ename,sal from emp where deptno = 10;
.
.
      fetch c_emp into er;
.
.
  close c_emp;
.
.
  open c_emp for select ename,sal from emp where deptno = 20;
.
.
      fetch c_emp into er;
.
.
  close c_emp;
.
.
end;
```
From the above skeleton, you can easily understand that every CURSOR is opened, used and closed before opening the same with the next SELECT statement.  

Working with REF CURSOR inside loops  
Sometimes, it may be necessary for us to work with REF CURSOR within loops.  Let us consider the following example:
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
  er rec_emp;
begin
  for i in (select deptno,dname from dept)
  loop
    open c_emp for select ename,sal from emp where deptno = i.deptno;
    dbms_output.put_line(i.dname);
    dbms_output.put_line('--------------');
    loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
    end loop;
    close c_emp;  
  end loop;
end;
```
As you can observe from the above program, I implemented a FOR loop as follows:
```sql
  for i in (select deptno,dname from dept)
  loop
      .
      .
  end loop;
```
The above loop iterates continuously for each row of the "dept" table.  The details of each row in "dept" (like deptno, dname etc.) will be available in the variable "i."  Using that variable (as part of the SELECT statement), I am working with REF CURSOR as follows:
```sql
 open c_emp for select ename,sal from emp where deptno = i.deptno;
```
Sub-programs can also be called sub-routines.  These are nothing but the divisions of the main program.  These divisions are named and are executed when they are called by name from the main program.  They will not get executed unless they are called.   

The following is an example:
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
  er rec_emp;
  procedure PrintEmployeeDetails is
  begin
    loop
      fetch c_emp into er;
      exit when c_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
    end loop;
  end;
begin
  for i in (select deptno,dname from dept)
  loop
    open c_emp for select ename,sal from emp where deptno = i.deptno;
    dbms_output.put_line(i.dname);
    dbms_output.put_line('--------------');
    PrintEmployeeDetails;
    close c_emp;  
  end loop;
end;
```
In the above program, the sub-routine is named "PrintEmployeeDetails."  You can observe that I am executing (or calling) the sub-routine from within the loop as follows:
```
  for i in (select deptno,dname from dept)
  loop
      .
      .
      PrintEmployeeDetails;
      .
      .
  end loop;
```
According to the above loop, the sub-routine gets executed for every iteration, which displays the employee information for the respective department.  

Passing REF CURSOR as parameters to sub-programs  

In the previous section, we already started working with sub-programs (or sub-routines).  In this section, I shall extend the same with the concept of "parameters" (or arguments).  Every sub-program (or sub-routine) can accept values passed to it in the form of "parameters" (or arguments).  Every parameter is very similar to a variable, but gets declared as part of a sub-program.  

Let us consider the following program:  
```sql
declare
  type r_cursor is REF CURSOR;
  c_emp r_cursor;
  type rec_emp is record
  (
    name  varchar2(20),
    sal   number(6)
  );
  procedure PrintEmployeeDetails(p_emp r_cursor) is
    er rec_emp;
  begin
    loop
      fetch p_emp into er;
      exit when p_emp%notfound;
      dbms_output.put_line(er.name || ' - ' || er.sal);
    end loop;
  end;
begin
  for i in (select deptno,dname from dept)
  loop
    open c_emp for select ename,sal from emp where deptno = i.deptno;
    dbms_output.put_line(i.dname);
    dbms_output.put_line('--------------');
    PrintEmployeeDetails(c_emp);
    close c_emp;  
  end loop;
end;
```
From the above program, you can observe the following declaration:
```sql
procedure PrintEmployeeDetails(p_emp r_cursor) is
```
In the above declaration, "PrintEmployeeDetails" is the name of the sub-routine which accepts "p_emp" as a parameter (of type "r_cursor") and we can use that parameter throughout that sub-routine.
