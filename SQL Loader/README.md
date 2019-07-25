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
6. Parallel Direct Path - A parallel direct path load allows multiple direct path load sessions to concurrently load the same data segments (allows intrasegment parallelism). Parallel direct path is more restrictive than direct path.
```
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc direct=true parallel=true
```
Happy learning
