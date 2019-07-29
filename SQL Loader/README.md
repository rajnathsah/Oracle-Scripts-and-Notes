1. Create a directory and place .ctl and .csv file

2. Using table creation script create table

3. Run sql loader command to load data
```
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc
```
4. Verify table data and log files

5. Direct path load (direct=true) - This approach is faster than conventional load method, A direct path load parses the input records according to the field specifications, converts the input field data to the column datatype, and builds a column array. The column array is passed to a block formatter, which creates data blocks in Oracle database block format. The newly formatted database blocks are written directly to the database, bypassing much of the data processing that normally takes place. This way it insert data faster.
```
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc direct=true
```
6. Parallel Direct Path - A parallel direct path load allows multiple direct path load sessions to concurrently load the same data segments (allows intrasegment parallelism). Parallel direct path is more restrictive than direct path. This is useful in cases where database server has multiple processor, in such cases mutiple session of sqlloader can be started to load data. Parallel load can only used with direct load.
```
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc direct=true parallel=true
```
7. Restriction on parallel load:- 
  1.Indexes are not maintained when a parallel direct path load is performed. You will need to rebuild all indexes on the table being         loaded   after the load is complete.
  2. There is no communication between the concurrent load sessions. Therefore, you can only append rows to a table. The TRUNCATE,              REPLACE and INSERT options of SQL*Loader cannot be used for a parallel direct path load.
  3. All referential integrity and CHECK constraints on the table being loaded must be disabled for the duration of the load.
  4. All triggers on the table being loaded must be disabled for the duration of the load.

Happy learning
