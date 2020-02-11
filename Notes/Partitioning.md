# Partitioning

Partitioning allows a table, index, or index-organized table to be subdivided into smaller pieces, where each piece of such a database object is called a partition. Each partition has its own name, and may optionally have its own storage characteristics.

1. Range partitioning
2. Hash partitioning
3. List partitioning
4. Interval partitioning
5. Composite partitioning

## Range partitioning
Range partitioning is a partitioning technique where ranges of data is stored separately in different partition.

Example:  
```sql
CREATE TABLE emp (
   empno NUMBER(4), 
   ename VARCHAR2(30), 
   sal   NUMBER
) 
PARTITION BY RANGE(empno) (
  partition e1 values less than (1000), 
  partition e2 values less than (2000), 
  partition e3 values less than (MAXVALUE)
); 
```
Here MAXVALUE is provided as a catch-all for values that exceed all ranges specified. Note that Oracle sorts NULLs greater than all other values, except MAXVALUE.  

## Hash partitioning
Hash partitioning is a partitioning technique where a hash key is used to distribute rows evenly across the different partitions (sub-tables). This is typically used where ranges aren't appropriate.  

Example:
```sql
create table emp (
   empno number(4), 
   ename varchar2(30), 
   sal   number
) 
partition by hash(empno) (
  partition e1, 
  partition e2, 
  partition e3,
  partition e4
);
```
