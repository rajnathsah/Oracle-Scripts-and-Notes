options (skip=1)
load data
append into table sales_det
Fields terminated by "," optionally enclosed by ' " '
Trailing nullcols
(
order_id,
sales_date date "dd-mm-yy",
sales_region,
sales_qty "to_number(trim(:sales_qty))"
)