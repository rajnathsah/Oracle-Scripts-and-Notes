set serveroutput on;
declare
type vtype is varray(5) of date;
vdates vtype := vtype(sysdate,sysdate+1,sysdate+2);
begin
-- print array item count
dbms_output.put_line(vdates.count);

-- assign new value to array
for i in 1..5 
loop
  if not vdates.exists(i) then
    vdates.extend;
    vdates(i) := sysdate + i;
  end if;
end loop;

-- print value
for i in 1..vdates.count
loop
 dbms_output.put_line(vdates(i));
end loop;
end;
