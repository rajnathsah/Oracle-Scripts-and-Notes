# Bit map index
#### How to create bit map index in Oracle database?
```sql
CREATE BITMAP INDEX emp_bitmap_idx ON index_demo (gender);
```
#### Gather index statistics
```sql
exec dbms_stats.gather_index_stats(OWNNAME=>'SCOTT', INDNAME=>'EMP_BITMAP_IDX');
```
Run query with the help of hints  
```sql
select /*+ index(emp emp_bitmap_idx) */
   count(*)
from
   emp, dept
where
   emp.deptno = dept.deptno;
```
#### Important points
* Bitmap indexes are only suitable for static tables and materialized views which are updated at non business hours and rebuilt after batch row loading.  
* If your tables are not read-only during query time, DO NOT consider using bitmap indexes!
* 1 - 7 distinct key values - Queries against bitmap indexes with a low cardinality are very fast.
* 8-100 distinct key values - As the number if distinct values increases, performance decreases proportionally.
* 100 - 10,000 distinct key values - Over 100 distinct values, the bitmap indexes become huge and SQL performance drops off rapidly.
* Over 10,000 distinct key values - At this point, performance is ten times slower than an index with only 100 distinct values.
