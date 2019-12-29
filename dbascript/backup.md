# Database Export Backup

Steps to take expdp backup of Oracle database on linux.  

1.  Check the space in file system.  
```shell
df -h
```

2.  Check the approximate space of data files and temp files  
```sql
select (select sum(bytes)/1024/1024 from dba_data_files)+
(select sum(bytes)/1024/1024 from dba_temp_files) "Size in MB" from dual;
```
If space is available then proceed to next step.  

3.  Query database directory and see if it exists  
```sql
select * from dba_directories;
```
If it does not returns any row then proceed to step 5 else proceed to step 6.  

4.  Create database directory and grant permission  
```sql
create directory DATA_PUMP_DIR as '/<path where you wish to save export file>'  
grant all on directory DATA_PUMP_DIR to <user>  
```

5.  Verify NLS_LANG environment value and database character set to avoid character set conversion while exporting database.  
```sql
echo $NLS_LANG

select * from nls_database_parameters  where parameter='NLS_CHARACTERSET';
```

6.  Run expdp command to export the backup for the schema  
```sql
expdp system/manager@orcl schemas=SCOTT directory=DATA_PUMP_DIR dumpfile=SCOTT.dmp logfile=expdpSCOTT.log
```

7.  Navigate to the backup path and verify dump file and log file.  
