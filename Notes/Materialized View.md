Materialized view
A materialized view or snapshot is a table segment whose contents are periodically refreshed based on a query, either against a local or remote table. Using a materialized view against remote table is simplest way to achieve replication of data between sites.

Syntax

CREATE MATERIALIZED VIEW VIEW_NAME
BUILD [IMMEDIATE | DEFFERED]
REFRESH [FAST | COMPLETE | FORCE]
ON [COMMIT | DEMAND]
[[ENABLE | DISABLE] QUERY REWRITE]
[ON PREBUILT TABLE]
AS 
SELECT ......;

IMMEDIATE : The materialized view is populated immediately.
DEFERRED  : The materialized view is populated on the first requested refresh.

FAST : A fast refresh is attempted, if materialized view logs are not present against source tables in advance then creation fails.
COMPLETE : The table segment supporting the materialized view is truncated and repopulated completely using the associated query.
FORCE : A fast refresh is attempted if one is not possible then a complete refresh is performed.

ON COMMIT : The refresh is triggered by a committed data change in one of the dependent tables.
ON DEMAND : The refresh is initiated by a manual request or a scheduled task.

CREATE MATERIALIZED VIEW m_emp
BUILD IMMEDIATE
REFRESH FORCE
ON DEMAND
ENABLE QUERY REWRITE
AS
SELECT * FROM emp;

EXEC DBMS_MVIEW.refresh('M_EMP');

