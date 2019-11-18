# Notes on Oracle Database PDB

To keep state of pluggable database open after database restart, open pluggable database and save its state
```sql
alter pluggable database orclpdb save state;
```
Remove the saved state.
```sql
alter pluggable database orclpdb discard state;
```
