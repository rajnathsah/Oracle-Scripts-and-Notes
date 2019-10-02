set serveroutput on;
declare
type age_type is table of number index by varchar2(64);
stud_age age_type;
stud_index varchar2(64);
begin
-- add value to array with index as name
stud_age('tom') := 30;
stud_age('king') :=29;

-- print age
stud_index := stud_age.first;
loop
exit when stud_index is null;
  dbms_output.put_line(stud_age(stud_index));
  stud_index := stud_age.next(stud_index);
end loop;  
end;
