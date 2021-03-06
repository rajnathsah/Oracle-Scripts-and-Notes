# Cursors
A cursor is a pointer which points towards a pre allocated memory location in the PGA. The memory location to which it points is known as context area, oracle associates every SELECT statement with a cursor to hold the query information in this context area.

##### There are two types of cursors
1. Implicit cursors
2. Explicit cursors

##### Implicit cursors
* Oracle sever processes every SQL statement in a PL/SQL block as an implicit cursor.
* All the DML and select query with INTO or BULK COLLECT clauses are candidates for implicit cursors.
* When a sql statement is executed, oracle automatically allocates a memory area known as context area in the PGA associated with the session.
* For implicit cursor, the complete execution cycle is internally handled and maintained by the oracle server.

##### Cursor attributes
* SQL%ROWCOUNT
* SQL%ISOPEN
* SQL%FOUND
* SQL%NOTFOUND

##### Explicit cursors
These cursors are explicity declared in the declaration section of the block. They posses a specific name and a static select statement attached to them. Explicit cursors are manually executed by the developers and follow the complete execution cycle.

##### Explicit cursor attributes are
* CURSOR%ROWCOUNT
* CURSOR%ISOPEN
* CURSOR%FOUND
* CURSOR%NOTFOUND

##### Cursor execution cycle
* Open-fetch-close

##### Open stage- 
* PGA memory allocation for cursor processing
* Parsing of select statement
* variable binding
* Select query execution
* Move the record pointer to the first record

##### Fetch stage
* The record to which record pointer points is pulled from the result set.Fetch phase lives until the last record is reached.

##### Close statge
After the last record of the result set is reached, cursor is closed and allocated memory is flushed off and released back to SGA. Even if and open cursor is not closed, oracle automatically closes it after the execution of its parent block.  

For update clause in cursor  
Ex.  
```sql
Set Serveroutput On;
Declare

Cursor C1 Is
Select Sal From Emp
Where Deptno=30
For Update Of Sal;

Begin
For I In C1
Loop
 Update Emp Set Sal=I.Sal+1200
 Where Current Of C1;
End Loop;
End;
end;
```
