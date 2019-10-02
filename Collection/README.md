# Collection

### Collections are single dimensional arrays of data, all with the same datatype and are accessed by an index. Or collection is an ordered group of elements, all of the same type.

# Records
### Records are groups of related data, each with its own field name and datatype, similar to tables stored in the database.


## Nested tables
A nested table is a column type that stores an unspecified number of rows in no particular order. When you retrieve a nested table value from the database into a PL/SQL nested table variable, PL/SQL gives the rows consecutive indexes, starting at 1. Using these indexes, you can access the individual rows of the nested table variable. The syntax is variable_name(index). The indexes and row order of a nested table might not remain stable as you store and retrieve the nested table from the database.The amount of memory that a nested table variable occupies can increase or decrease dynamically, as you add or delete elements.  

1. Nested tables hold a random number of elements.   
2. It uses sequential numbers as subscripts.  
3. It can be stored into database by defining equivalent sql types.  
4. Nested tables can be considered as one column databases tables.  
5. Initially nested tables are dense like array but it allows us to delete item in between using the procedure DELETE which can leave gaps in between.  
6. In order to iterate through elements we use built in function NEXT.  
7. In other word nested tables are like arrays with exception, nested tables are unbounded and allows us to delete item in between. 

Example code [Nested Table](https://github.com/rajnathsah/Oracle-Scripts-and-Notes/blob/master/Collection/nestedtable.sql) script.  

For more detail, please refer official Oracle documentation of [nested table](https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/composites.htm#LNPLS99981)  


# Associative arrays/Index by table
An associative array (formerly called PL/SQL table or index-by table) is a set of key-value pairs. Each key is a unique index, used to locate the associated value with the syntax variable_name(index).

1. It let us lookup using arbitrary numbers and strings for subscript values. 
2. It is like hashtable. Best suited for collections where the number of elements stored is not known until runtime.
3. The data type of index can be either a string type or PLS_INTEGER. Indexes are stored in sort order, not creation order. For string types, sort order is determined by the initialization parameters NLS_SORT and NLS_COMP.
4. It can be used for a relatively small lookup table, which can be constructed in memory each time you invoke the subprogram or initialize the package that declares it
5. It can also be used for passing collections to and from the database server

Example code [Associative Array](https://github.com/rajnathsah/Oracle-Scripts-and-Notes/blob/master/Collection/associative_array.sql)  

For more detail, please refer official Oracle documentation of [associative array](https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/composites.htm#LNPLS99969)


# Varray
A varray (variable-size array) is an array whose number of elements can vary from zero (empty) to the declared maximum size. To access an element of a varray variable, use the syntax variable_name(index). The lower bound of index is 1; the upper bound is the current number of elements. The upper bound changes as you add or delete elements, but it cannot exceed the maximum size. When you store and retrieve a varray from the database, its indexes and element order remain stable.  

1. Variable size array which holds a fix number of elements which can be changed at runtime. 
2. They use sequential number as subscript and like nested table varrays can also be stored in database by defining equivalent sql types. 
3. Elements can not be deleted in between varray and because of that it remain dense.

Example code [Varray](https://github.com/rajnathsah/Oracle-Scripts-and-Notes/blob/master/Collection/varray.sql)

For more detail, please refer official Oracle documentation of [varray](https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/composites.htm#LNPLS443)  
