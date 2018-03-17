# Magic Indexing
Custom Lua table indexing by functions


(Ab)uses metatables to achieve *\~magic\~* indexing of table values, so that you can execute a function to determine what value to return.

Can also be used to compute table values that don't really exist on the table.

### Usage
Load MI by requiring it as you would any other module.

To use MI on a table, wrap it with `mi.wrap(table)`. **This returns a new table** with MI's features.

### Supported indexing function names
- GetKey
- GETKEY
- getKey
- getkey
- get_key
- get_Key
