# AWR Report
#### Points to looks for in awr report  

1. DB Time
2. Instance efficiency
3. Top 10 foreground events by wait time

#### Method to run awr report  

Move to $ORACLE_HOME/rdbms/admin and run awrrpt.sql from sys

Enter report type  
Enter value for num_days  
Begin snap  
End snap  
report name  

# ASH report

Helps in getting session level details which may not been captured in AWR report  

#### Points to look for in ASH report  
1. Top user events
2. Top background events
3. Top event p1/p2/p3 values db/inst
4. Top service/module
5. Top sql command types db/inst
6. Top sql statement
7. Top sessions
8. Top blocking sessions
9. Top db objects
10. Top db files
11. Activity over time


#### Method to run awr report  

Move to $ORACLE_HOME/rdbms/admin and run ashrpt.sql file  

enter report type  
begin time  
duration  
report name  
