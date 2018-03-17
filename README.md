# Magic Indexing
Custom Lua table indexing by functions


(Ab)uses metatables to achieve *\~magic\~* indexing of table values, so that you can execute a function to determine what value to return.

Can also be used to compute table values that don't really exist on the table.

### Usage
Load MI by requiring it as you would any other module.

To use MI on a table, wrap it with `mi.wrap(table)`. **This returns a new table** with MI's features, so it's a good idea to wrap the table as you're defining it.

### Notes

If you need access to the *real* table which contains the table values, you can do it through `mi_table.real_table.some_key`

The real table isn't touched by MI, so you're free to set a metatable for the real table for some spaghetti-tier double-layer metatable action.

### Supported indexing function names
- GetKey
- GETKEY
- getKey
- getkey
- get_key
- get_Key
