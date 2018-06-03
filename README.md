# Magic Indexing
Custom Lua table indexing by functions


(Ab)uses metatables to achieve :sparkles:*magic*:sparkles: indexing of table values, so that you can execute a function to determine what value to return. In other words, it allows you to create getter functions for your table values.

It can also be used to compute table values that don't actually exist on the table.

### Usage
Load MI by requiring it as you would any other module.

To use MI with a table, wrap it with `mi.wrap(table)`. **This returns a new table** with MI's features, so it's a good idea to wrap the table as you're defining it. E.g. `local mi_table = mi.wrap({foo = 1, bar = 2})`

After wrapping a table, you can define indexing functions for the table values. See ![test.lua](test.lua) for examples.

### Notes

If you need access to the *real* table which actually contains the table values, you can get it with `mi_table.real_table`

The real table won't have a metatable set on it. MI only reads and writes to it, so you're free to set a metatable for the real table for some exciting double-layer metatable action.

### Proper indexing function names
Every indexing function needs to start with "get", followed by the exact name of the key the indexing function is for. You can add an underscore between "get" and the key name if you like. Indexing function names are case insensitive.
