# Trace File
Trace files are trace dump that is created by Oracle to the purpose of diagnosing the proble. SQL_TRACE enables or disables the SQL trace facility. Setting this parameter to true provides information on tuning that you can use to improve performance. You can change the value using the DBMS_SYSTEM package.

### How to enable trace?
Before starting trace it is always better to set trace identifier, this helps in finding trace file.
```sql
ALTER session SET tracefile_identifier = 'myIdentifier';
```
To get the most out of this utility, enable timed statistics by updating parameter file or for a session by running below command.
```sql
ALTER SYSTEM SET TIMED_STATISTICS = TRUE;
```
Then change the setting of trace to true of the session:
```sql
ALTER SESSION SET SQL_TRACE = TRUE;
```
Perform the sql operation in session and set trace off.
```sql
ALTER session SET sql_trace = FALSE;
```
Next step is to find the trace file. For that check the value of parameter user_dump_dest.
```sql
show parameter user_dump_dest
```
Or use query to find the path
```sql
SELECT s.sid,
       s.serial#,
       pa.value || '/' || LOWER(SYS_CONTEXT('userenv','instance_name')) ||    
       '_ora_' || p.spid || '.trc' AS trace_file
FROM   v$session s,
       v$process p,
       v$parameter pa
WHERE  pa.name = 'user_dump_dest'
AND    s.paddr = p.addr
AND    s.audsid = SYS_CONTEXT('USERENV', 'SESSIONID');
```
Navigate to the trace path and look for the file with name set in identifier. Trace files are in raw format but can be read. Oracle provide another tool [TKPROF](https://docs.oracle.com/database/121/TGSQL/tgsql_trace.htm#TGSQL793). Using tkprof, trace file can be translated into more human readable format.
```sql
tkprof <trace_file_name> <output_file_name>
```
For more details on trace file formatting, Please refer Oracle database [link](https://docs.oracle.com/cd/E11882_01/server.112/e41573/sqltrace.htm#PFGRF94985)

### What to look for in trace file?

