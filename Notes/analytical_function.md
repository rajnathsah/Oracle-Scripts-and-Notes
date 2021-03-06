# Analytical Functions
1. View emp table data.
```sql
select * from emp;
```
2. Get the running total
```
Select Ename, Deptno, Sal, Sum(Sal) Over(Order By Deptno,Ename) "Running total",
sum(sal) over(partition by deptno order by ename) "dept total"
from emp;
```
3. Using row_number() to get top 3 salary details
```sql
Select * From (
  Select Empno, Ename, Sal, Row_Number()
    Over (Partition By() Order By Sal Desc) r
    From Emp)
    Where R<=3;
```
4. Get first value of column using first_value() function
```sql
SELECT empno, deptno, sal, 
       FIRST_VALUE(sal IGNORE NULLS) OVER (PARTITION BY deptno) AS first_sal_in_dept
FROM   emp;
```
5. Get sum of salary department wise
```sql
Select Ename,Deptno, Sal,
  sum(Sal) Over (Partition By Deptno) As Sum_Dept_Sal
  from emp;
```  
6. Get sum of salary
```sql
Select Ename, Deptno, Sal, Sum(Sal) Over() As Sum_Sal
from emp;
```
7. Rank data department wise based on salary using rank()
```sql
Select Empno,Deptno,Sal,
        Rank() Over (Partition By deptno Order By Sal) "rank"
From Emp;
```
8. Rank data department wise based on salary using dense_rank()
```sql
Select Empno, Deptno, Sal,
        Dense_Rank() Over(Partition By Deptno Order By Sal) "rank"
from emp;       
```
9. Get department wise min and max salary
```sql
Select Empno, Deptno,Sal,
        Min(Sal) Keep (Dense_Rank First Order By Sal) Over(Partition By Deptno) "lowest",
        Max(Sal) Keep (Dense_Rank Last Order By Sal) Over (Partition By Deptno) "highest"
from emp;
```
10. Get previous row salary and salary difference
```sql
Select Empno, Ename,Job, Sal,
        Lag(Sal,1,0) Over (Order By Sal) As Sal_Prev,
        sal-lag(sal,1,0) over (order by sal) as sal_diff
        From Emp;
```
11. Get next salary
```sql
Select Empno, Ename, Job, Sal,
        Lead(Sal,1,0) Over (Order By Sal) As Sal_Next
        from emp;
```
12. Get highest salary employee details
```sql
Select * From 
  (Select Emp.Empno, 
          Emp.Ename, 
          Emp.Sal, 
          Emp.Deptno, 
          Row_Number() Over( Order By Emp.Empno) R 
      From Emp, 
           Dept
      Where Dept.Deptno=Emp.Deptno
      and Emp.Deptno=10)
  where r=1;
```
