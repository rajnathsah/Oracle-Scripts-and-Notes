# Oracle Database Parameter

1. To see all parameter use
```sql
show parameter;
```
2. v$parameter view shows all parameter  
3. v$parameter2 displays value of spfile, if spfile not in use then it display value as false  
4. v$spparameter displays parameter value which are in use  
5. v$system_parameter displays parameter that are currently in effect for the instance    

#### Important points
```sql
create pfile from spfile
create pfile ='initORCL.ora' from spfile; 
```

shutdown database  

rename spfile to some other file  

startup and check spfile parameter to see which file is used  
