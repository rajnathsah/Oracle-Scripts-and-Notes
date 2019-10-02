set serveroutput on;
declare
type table_type is table of number(10);
v_tab table_type;
v_idx number;
begin
-- initialize v_tab with two value 11,22
v_tab := table_type(11,22);

-- print the value
-- get first item index and store in v_idx variable
dbms_output.put_line('Value in v_tab after initilization');
v_idx := v_tab.first;
-- loop for all index to print value
while v_idx is not null
loop
    dbms_output.put_line(v_tab(v_idx));
    v_idx := v_tab.next(v_idx);
end loop;

-- add one value by extending v_tab
v_tab.extend;
v_tab(v_tab.last) := 33;

-- print the value
-- get first item index and store in v_idx variable
dbms_output.put_line('Value in v_tab after adding 1 item');
v_idx := v_tab.first;
-- loop for all index to print value
while v_idx is not null
loop
    dbms_output.put_line(v_tab(v_idx));
    v_idx := v_tab.next(v_idx);
end loop;

-- add multiple value in v_tab
for idx in 1..5
loop
    v_tab.extend;
    v_tab(v_tab.last) := idx+100;
end loop;

-- print the value
-- get first item index and store in v_idx variable
dbms_output.put_line('Value in v_tab after adding multiple items');
v_idx := v_tab.first;
-- loop for all index to print value
while v_idx is not null
loop
    dbms_output.put_line(v_tab(v_idx));
    v_idx := v_tab.next(v_idx);
end loop;

-- delete item of index 4 having value 101
v_tab.delete(4);
-- print the value
-- get first item index and store in v_idx variable
dbms_output.put_line('Value in v_tab after adding multiple items');
v_idx := v_tab.first;
-- loop for all index to print value
while v_idx is not null
loop
    dbms_output.put_line(v_tab(v_idx));
    v_idx := v_tab.next(v_idx);
end loop;
end;
