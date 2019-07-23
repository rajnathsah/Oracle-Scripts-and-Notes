1. Create a directory and place .ctl and .csv file

2. Using table creation script create table

3. Run sql loader command to load data
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc

4. Verify table data and log files

5. Happy learning
