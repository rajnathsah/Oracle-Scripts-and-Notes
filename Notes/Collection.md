# Collections
Collections are single dimensional arrays of data, all with the same datatype and are accessed by an index Or collection is an ordered group of elements, all of the same type.

# Records
Records are groups of related data, each with its own field name and datatype, similar to tables stored in the database.

### Nested tables
* Nested tables hold a random number of elements. 
* They use sequential numbers as subscripts. 
* It can be stored into database by defining equivalent sql types.
* Nested tables can be considered as one column databases tables. 
* Initially nested tables are dense like array but it allows us to delete item in between using the procedure DELETE which can leave gaps in between. 
* In order to iterate through elements, we use built in function NEXT. 
* In other word nested tables are like arrays with exception, nested tables are unbounded and allows us to delete item in between.

Example  
```sql
SET SERVEROUTPUT ON;
DECLARE
TYPE TABLE_TYPE IS TABLE OF NUMBER(10);
V_TAB TABLE_TYPE;
V_IDX NUMBER;
BEGIN
V_TAB := TABLE_TYPE(1,2);

FOR I IN 3..5 
LOOP
 V_TAB.EXTEND;
 V_TAB(I):= I;
END LOOP;
V_TAB.DELETE(3);
V_IDX := V_TAB.FIRST;
WHILE V_IDX IS NOT NULL
LOOP
  DBMS_OUTPUT.PUT_LINE(V_TAB(V_IDX));
  V_IDX := V_TAB.NEXT(V_IDX);
END LOOP;
END;
```

### Associative arrays/Index by table
* It lets us lookup using arbitrary numbers and strings for subscript values. 
* It is like hashtable. 
* Best suited for collections where the number of elements stored is not known until runtime.

Example  
```sql
SET SERVEROUTPUT ON;
DECLARE
TYPE AGE_TYPE IS TABLE OF NUMBER INDEX BY VARCHAR2(64);
STUD_AGE AGE_TYPE;
STUD_INDEX VARCHAR2(64);
BEGIN
STUD_AGE('raj') := 30;
STUD_AGE('som') :=29;

STUD_INDEX := STUD_AGE.FIRST;
LOOP
EXIT WHEN STUD_INDEX IS NULL;
  DBMS_OUTPUT.PUT_LINE(STUD_AGE(STUD_INDEX));
  STUD_INDEX := STUD_AGE.NEXT(STUD_INDEX);
END LOOP;  
END;
```

### Varray
* Variable size array which holds a fix number of elements which can be changed at runtime. 
* They use sequential number as subscript and like nested table varrays can also be stored in database by defining equivalent sql types. * Elements can not be deleted in between varray and because of that it remain dense.

Example  
```sql
SET SERVEROUTPUT ON;
DECLARE
TYPE VTYPE IS VARRAY(5) OF DATE;
VDATES VTYPE := VTYPE(SYSDATE,SYSDATE+1,SYSDATE+2);
BEGIN
DBMS_OUTPUT.PUT_LINE(VDATES.COUNT);

FOR I IN 1..5 
LOOP
  IF NOT VDATES.EXISTS(I) THEN
    VDATES.EXTEND;
    VDATES(I) := SYSDATE + I;
  END IF;
END LOOP;

FOR I IN 1..VDATES.COUNT
LOOP
 DBMS_OUTPUT.PUT_LINE(VDATES(I));
END LOOP;
END;
```

### Collection methods
* exists
* count
* limit
* first
* last
* prior
* next
* extend
* extend(n)
* extend(n1,n2)
* trim
* trim(n)
* delete
* delete(n)
* delete(n1,n2)
