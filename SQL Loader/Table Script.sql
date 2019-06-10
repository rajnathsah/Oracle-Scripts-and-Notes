create table sales_det(
    order_id number primary key,
    sales_date date,
    sales_region varchar2(100),
    sales_qty number
)
/


-- sql loader command 
sqlldr control=Sample.ctl log=export.log, bad=export.bad, data=export.csv userid=hr/hr@pdborcl, discard=export.dsc