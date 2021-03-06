# Decode and Case
DECODE and CASE statements (in Oracle) provides a conditional construct, of this form:
```
if A = n1 then A1
else if A = n2 then A2
else X
```

* Oracle database prior to 8.1.6 only had DECODE function. 
* CASE was introduced in Oracle 8.1.6 as a standard, more meaningful and more powerful function.
* Everything DECODE can do, CASE can. There is a lot else CASE can do though, which DECODE cannot.
* DECODE performs an equality check only. CASE is capable of other logical comparisons such as < > etc. 

An example of putting employees in grade brackets based on their salaries.  
This can be done elegantly with CASE.  
```sql
select ename,case
               when sal < 1000
                  then 'Grade I'
               when (sal >=1000 and sal < 2000)
                  then 'Grade II'
               when (sal >= 2000 and sal < 3000)
                  then 'Grade III'
               else 'Grade IV'
            end sal_grade
   from emp
   where rownum < 4;
```
```sql
ENAME      SAL_GRADE
---------- ---------
SMITH      Grade I
ALLEN      Grade II
WARD       Grade II
```

* CASE can work with predicates and searchable subqueries, DECODE works with expressions that are scalar values only. 

An example of categorizing employees based on reporting relationship, showing these two uses of CASE.
```sql
 select e.ename,case
                -- predicate with "in"
                -- mark the category based on ename list
                when e.ename in ('KING','SMITH','WARD')
                then 'Top Bosses'
                -- searchable subquery
                -- identify if this emp has a reportee
                when exists (select 1 from emp emp1
                        where emp1.mgr = e.empno)
                then 'Managers'
                else
                'General Employees'
                end emp_category
from emp e
where rownum < 5;
```
```sql
ENAME      EMP_CATEGORY
---------- -----------------
SMITH      Top Bosses
ALLEN      General Employees
WARD       Top Bosses
JONES      Managers
```
* CASE can work as a PL/SQL construct whereas DECODE can work as a function inside SQL only. CASE can be an efficient substitute for IF-THEN-ELSE in PL/SQL.
```sql
declare
     grade char(1);
   begin
     grade := 'b';
     case grade
       when 'a' then dbms_output.put_line('excellent');
       when 'b' then dbms_output.put_line('very good');
       when 'c' then dbms_output.put_line('good');
       when 'd' then dbms_output.put_line('fair');
       when 'f' then dbms_output.put_line('poor');
       else dbms_output.put_line('no such grade');
    end case;
   end;
```
* CASE can even work as a parameter to a procedure call, while DECODE cannot.
```sql
SQL> var a varchar2(5);
SQL> exec :a := 'THREE';
 
 create or replace procedure proc_test (i number)
    as
   begin
      dbms_output.put_line('output = '||i);
    end;
    /
 
Procedure created.
 
SQL> exec proc_test(decode(:a,'THREE',3,0));
BEGIN proc_test(decode(:a,'THREE',3,0)); END;
 
                *
ERROR at line 1:
ORA-06550: line 1, column 17:
PLS-00204: function or pseudo-column 'DECODE' may be used inside a SQL
statement only
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored
 
 
SQL> exec proc_test(case :a when 'THREE' then 3 else 0 end);
output = 3
 
PL/SQL procedure successfully completed.
```
* Careful! CASE handles NULL differently, Check out the different results with DECODE vs NULL.
```sql
    select decode(null
                , null, 'NULL'
                      , 'NOT NULL'
                ) null_test
    from dual;
```
```
NULL
----
NULL
```
```sql
   select case null
          when null
           then 'NULL'
           else 'NOT NULL'
           end null_test
    from dual;
```
```
NULL_TES
--------
NOT NULL
```

The “searched CASE” works as does DECODE.
```sql
select case
          when null is null
           then 'NULL'
           else 'NOT NULL'
           end null_test
   from dual;
```
```
NULL_TES
--------
NULL
```
* CASE expects datatype consistency, DECODE does not compare the two examples below- DECODE gives you a result, CASE gives a datatype mismatch error.
```sql
 select decode(2,1,1,
               '2','2',
               '3') t
    from dual; 
```
```
         T
----------
         2 
```
```sql
 select case 2 when 1 then '1'
                when '2' then '2'
                else '3'
           end
    from dual;
```
```
when '2' then '2'
     *
ERROR at line 2:
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
```
* CASE is ANSI SQL-compliant, CASE complies with ANSI SQL. DECODE is proprietary to Oracle.
* The difference in readability, In very simple situations, DECODE is shorter and easier to understand than CASE.
```sql
    select ename,decode (deptno, 10, 'Accounting',
                                 20, 'Research',
                                 30, 'Sales',
                                 'Unknown') as department
    from   emp
    where rownum < 4;
```
```
ENAME      DEPARTMENT
---------- ----------
SMITH      Research
ALLEN      Sales
WARD       Sales
```
```sql
select  ename, case deptno
                    when 10 then 'Accounting'
                    when 20 then 'Research'
                    when 30 then 'Sales'
                    else         'Unknown'
                end as department
 from emp
 where rownum < 4;
```
```
ENAME      DEPARTMENT
---------- ----------
SMITH      Research
ALLEN      Sales
WARD       Sales
```
Complicated logical comparisons in DECODE, even if technically achievable, are a recipe for messy, bug-prone code. When the same can be done more cleanly with CASE, go for CASE
