# Deterministic function
The deterministic functions indicate that the function will always return the same output for any given input arguments. We all know that whenever we use a function on the predicate in where clause, the index available on the column (if any) will be suppressed there by providing altogether a different execution plan. This could affect the execution of the query.

Example
```sql
create index idx_normal on emp(comm);
select count(*) from emp where comm=300;--COST 1 CARDINALITY 1 BYTE 2
select count(*) from emp where comm is null;--COST 2 CARDINALITY(ROWS) 10 BYTE 20
```
Above query went for full table scan. We know that the nulls are not stored in indexes. For this Oracle has provided a deterministic function called NVL on which we can create a function-based index.  

To know what deterministic function really means or does, let us create our own deterministic function. 
The function will check for null values in the column. If column has null then the function will replace it with ‘0’.First let us create normal function and check whether it works.  
```sql
create or replace function check_null(p_int in integer) 
    return integer 
    as 
    begin 
       if p_int is null then 
          return 0; 
       else 
          return p_int; 
       end if; 
   end; 
   /
```
```sql
select check_null(comm) from emp;
```
As expected nulls are replaced with 0. Try creating an index on this function. 
```sql
create index idx_non_deterministic on emp(check_null(comm)); 
create index idx_non_deterministic on emp(check_null(comm)) 
* 
ERROR at line 1: 
ORA-30553: The function is not deterministic
```
Hence to create an index on a user defined function, we need to create a deterministic function.
```sql
create or replace function check_null(p_int in integer) 
    return integer 
    deterministic 
    as 
    begin 
       if p_int is null then 
          return 0; 
       else 
          return p_int; 
      end if; 
   end;
```
Try creating function based index again.
```sql
create index idx_deterministic on emp(check_null(comm));
```
Index got created, run the query.
```sql
select * from emp where check_null(comm)=0;
```
