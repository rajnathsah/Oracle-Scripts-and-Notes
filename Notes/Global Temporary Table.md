# Global Temporary Table

Applications often use some form of temporary data store for processes that are too complicated to complete in a single pass. Often, these temporary stores are defined as database tables or PL/SQL tables. This maintenance and management of temporary tables can be delegated to the server by using Global Temporary Tables.  

The data in a global temporary table is private, such that data inserted by a session can only be accessed by that session. The session-specific rows in a global temporary table can be preserved for the whole session, or just for the current transaction. The ON COMMIT DELETE ROWS clause indicates that the data should be deleted at the end of the transaction.  
```sql
CREATE GLOBAL TEMPORARY TABLE my_temp_table (
  column1  NUMBER,
  column2  NUMBER
) ON COMMIT DELETE ROWS;--transaction spcific
```
In contrast, the ON COMMIT PRESERVE ROWS clause indicates that rows should be preserved until the end of the session.
```sql
CREATE GLOBAL TEMPORARY TABLE my_temp_table (
  column1  NUMBER,
  column2  NUMBER
) ON COMMIT PRESERVE ROWS; --session specific
```
##### Miscellaneous Features

* If the TRUNCATE statement is issued against a temporary table, only the session specific data is trucated. There is no affect on the data of other sessions.
* Data in temporary tables is stored in temp segments in the temp tablespace.
* Data in temporary tables is automatically deleted at the end of the database session, even if it ends abnormally.
* Indexes can be created on temporary tables. The content of the index and the scope of the index is the same as the database session.
* Views can be created against temporary tables and combinations of temporary and permanent tables.
* Temporary tables can have triggers associated with them.
* Export and Import utilities can be used to transfer the table definitions, but no data rows are processed.
* Statistics on temporary tables are common to all sessions. Oracle 12c allows session specific statistics.
* There are a number of restrictions related to temporary tables but these are version specific.

##### Difference Between Global Temporary Tables and PL/SQL tables or associative array

* GTT is stored in Temp Table Space. Associative Array are stored in your PGA. 
* GTT is a physical table structure. The object is persistent but the data is not. The persistency of the data can be defined at transaction level or at session level.
* GTT is available to the entire database like any normal table. But Associative Array is just private to the procedure in which its used. 
* SQL operations cannot be performed on Associative Array. You can perform SQL Operation on GTT like we do in a normal table.
* The contents of a GTT will obey to semantics of rollback and rollback to savepoint. An associative array will not.
* If the amount of data to be processed or utilized from your PL/SQL procedure is too large to fit comfortably in a PL/SQL table, use a GLOBAL TEMPORARY table rather than a normal table. 
* A GLOBAL TEMPORARY table has a persistent definition but data is not persistent and the global temporary table generates no redo or rollback information. For example if you are processing a large number of rows, the results of which are not needed when the current session has ended, you should create the table as a temporary table instead.
* GTT's take on the characteristics of an SQL table and can have indexes applies and can be used just like any other table in a query, except the data contained in them is specific to the session or transaction.
* Collections may or may not be able to be used in SQL depending on the type of collection you have created. Typically a collection defined in PL/SQL code cannot be used in an SQL statement as the SQL engine does not have access to the PL/SQL data structures.
