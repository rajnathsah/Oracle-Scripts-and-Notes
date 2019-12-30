# RMAN
Recovery Manager (RMAN) is an Oracle Database client that performs backup and recovery tasks on your databases and automates administration of your backup strategies. It greatly simplifies backing up, restoring, and recovering database files.

# Backup and Recovery using RMAN

#### Connect to RMAN
1. Using rman keyword followed by connect target keyword
```sql
% rman
RMAN> CONNECT TARGET SYS@prod

target database Password: password
connected to target database: PROD (DBID=39525561)
```
Other option of logging is using os authentication.
```sql
% rman
RMAN> CONNECT TARGET /

connected to target database: PROD (DBID=39525561)
```
To quit RMAN, enter EXIT keyword
```sql
RMAN> EXIT
```
2. View the current RMAN configuration for a database:
Connect to RMAN and run show all
```sql
RMAN> SHOW ALL;
```
3. Configure RMAN backup location
```sql
RMAN> CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/backup/rman/full_%u_%s_%p';
```
4. Configure retention period
```sql
RMAN> CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
```
5. To clear any RMAN parameter use CLEAR command. Clear command reset the parameter back to default.
```sql
RMAN> CONFIGURE RETENTION POLICY CLEAR;
```
6. Backup the database
   * Backup without archive logs  
    ```sql
    RMAN> BACKUP AS BACKUPSET DATABASE
    ```
   * Backup with archive logs  
    ```sql
    RMAN> BACKUP AS BACKUPSET DATABASE PLUS ARCHIVELOG;
    ```
   * Backup specific tablespace  
    ```sql
    RMAN> BACKUP AS BACKUPSET TABLESPACE PRD01;
    ```
   *  For easy identification, backup can be tagged also  
    ```sql
    BACKUP AS BACKUPSET TAG 'WEEEKLY_PRD01_TBLS_BK_ONLY' TABLESPACE PRD01;
    ```
7. Verify backup in file system
```shell
$ls -l /backup/rman
```
8. View all RMAN backups
```sql
RMAN> LIST BACKUP SUMMARY;
```
#### RMAN recovery
1. Restore controlfile from backup
```sql
RMAN> STARTUP NOMOUNT;
RMAN> RESTORE CONTROLFILE FROM "/backup/rman/ctl_c-12345-20191212-03";
RMAN> ALTER DATABASE MOUNT;
```
2. Restore controlfile based on tag
```sql
RMNAN> RESTORE CONTROLFILE FROM TAG 'WEEKLY_FULL_BKUP';
```
3. Restore controlfile from autobackup
```sql
RMNAN> RESTORE CONTROLFILE FROM AUTOBACKUP;
```
4. Restore the database
```sql
RMAN> RESTORE DATABASE;
```
5. In case controlfiles are restored from backup then use below command
```sql
RMAN> RECOVER DATABASE;
RMAN> ALTER DATABASE OPEN RESETLOGS;
```
6. Restore specific tablespace
```sql
RMNAN> RESTORE TABLESPACE dev1;
RMNAN> RESTORE TABLESPACE dev1, dev2; # restoring multiple tablespaces
```
7. Restore specific datafiles
```sql
RMNAN> RESTORE DATAFILE '/u01/oradata/devdb/dev1_01.dbf'
RMNAN> RESTORE DATAFILE '/u01/oradata/devdb/dev1_01.dbf', '/u01/oradata/devdb/dev1_02.dbf' # restoring multiple datafiles
```
8. Restore archived redo logs
```sql
RMNAN> RESTORE ARCHIVELOG ALL;
```
9. Preview the restore
```sql
RMAN> RESTORE DATABASE PREVIEW;
```
10. Preview summary of restore
```sql
RMAN> RESTORE DATABASE PREVIEW SUMMARY;
```
11. Validate the backup before restore
```sql
RMAN> RESTORE DATABASE VALIDATE;
```

Happy Learning!
