# Collection

### Collections are single dimensional arrays of data, all with the same datatype and are accessed by an index. Or collection is an ordered group of elements, all of the same type.

# Records
### Records are groups of related data, each with its own field name and datatype, similar to tables stored in the database.


## Nested tables
1. Nested tables hold a random number of elements.   
2. It uses sequential numbers as subscripts.  
3. It can be stored into database by defining equivalent sql types.  
4. Nested tables can be considered as one column databases tables.  
5. Initially nested tables are dense like array but it allows us to delete item in between using the procedure DELETE which can leave gaps in between.  
6. In order to iterate through elements we use built in function NEXT.  
7. In other word nested tables are like arrays with exception, nested tables are unbounded and allows us to delete item in between. 

For example check the [Nested Table](https://github.com/rajnathsah/Oracle-Scripts-and-Notes/blob/master/Collection/nestedtable_example.sql) script.
