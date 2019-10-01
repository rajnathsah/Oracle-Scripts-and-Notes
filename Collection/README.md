# Collection

### Collections are single dimensional arrays of data, all with the same datatype and are accessed by an index. Or collection is an ordered group of elements, all of the same type.

# Records
### Records are groups of related data, each with its own field name and datatype, similar to tables stored in the database.


## Nested tables
Nested tables hold a random number of elements. It uses sequential numbers as subscripts. It can be stored into database by defining equivalent sql types. Nested tables can be considered as one column databases tables. Initially nested tables are dense like array but it allows us to delete item in between using the procedure DELETE which can leave gaps in between. In order to iterate through elements we use built in function NEXT. In other word nested tables are like arrays with exception, nested tables are unbounded and allows us to delete item in between.  
