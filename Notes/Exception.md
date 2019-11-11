# Exception
An exception is a section in a PL/SQL program that captures and processes runtime errors or An exception is a PL/SQL error that is raised during program excecution either implicitly or explicitly.

#### Exception type:-
1. Named system exception :- These are error condition that are defined by PL/SQL and are raised automatically by oacle when a program violates a RDBMS rule. These are some exception which are raised frequently so they are pre-defined and given a name in oracle.
2. Unnamed system exception :- These are the system excetion for which oracle does not provide a name is known as unnamed system exception. These exception do not occur frequently. These exceptions have a code and a associated message.

There are two ways to handle unnamed exceptions:
* By using when others exception handler or
* By associating the exception code to a name and using it as a named exception.

Example  
```sql
DECLARE
	EXCEPTION_NAME EXCEPTION;
	PRAGMS EXCEPTION_INIT (EXCEPTION_NAME, ERR_CODE);
BEGIN
	EXECUTION SECTION
 EXCEPTION
	WHEN EXCEPTION_NAME THEN
	HANDLE THE EXCEPTION;
END;
```
Example
```sql
DECLARE 
  Child_rec_exception EXCEPTION; 
  PRAGMA 
   EXCEPTION_INIT (Child_rec_exception, -2292); 
BEGIN 
  Delete FROM product where product_id= 104; 
EXCEPTION 
   WHEN Child_rec_exception 
   THEN Dbms_output.put_line('Child records are present for this product_id.'); 
END; 
```
3. User-defined exception  :- These are exception specific to your application.
Steps to be followed to use user-defined exceptions: 
* They should be explicitly declared in the declaration section. 
* They should be explicitly raised in the Execution Section. 
* They should be handled by referencing the user-defined exception name in the exception section.
```sql
DECLARE
	EXCEPTION_NAME EXCEPTION;		
BEGIN
	EXECUTION SECTION
 EXCEPTION
	WHEN EXCEPTION_NAME THEN
	HANDLE THE EXCEPTION;
END;
```

RAISE_APPLICATION_ERROR()  
RAISE_APPLICATION_ERROR is a built in procedure in oracle which is used to display the user defined error messages along with error number whose range in between -20000 and -20999. Whenever a message is displayed using RAISE_APPLICATION_ERROR, all previous transactions which are not commited within the PL/SQL block are rolled back automatically. RAISE_APPLICATION_ERROR raises an exception but does not handle it.

RAISE_APPLICATION_ERROR is used for the following reasons   
* To create a unique id for an user-defined exception. 
* To make the user-defined exception look like an Oracle error.

The General Syntax to use this procedure is:
```sql
RAISE_APPLICATION_ERROR (error_number, error_message); 
```
Below two are important utility to trace error in procedural code.  
* DBMS_UTILITY.FORMAT_ERROR_STACK
* DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
