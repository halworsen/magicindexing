--[[
	MagicIndexing
	-------------

	(Ab)uses metatables to achieve **magic** indexing of table values, so that you
	can run some code to determine what value to return.

	Can also be used to compute table values that don't really exist on the table.
--]]

-------------------
--    Utility    --
-------------------

-- Basic matcher for an index function
-- Matches for:
--  GetKey
--  getkey
--  getKey
--  get_key
--  get_Key
local function indexer_match(table, key)
	local capitalized = key:gsub("^%l", string.upper)
	local lower_case = string.lower(key)

	local tests = {
		"Get"..capitalized,
		"get"..lower_case,
		"get"..capitalized,
		"get_"..lower_case,
		"get_"..capitalized,
	}

	for k, name in pairs(tests) do
		local indexer = rawget(table, name)
		if indexer then
			return indexer
		end
	end
end

-------------------
-- Wrapper meta  --
-------------------

local MI_META = {}
MI_META.real_table = nil

function MI_META:__index(key)
	-- Pass off indexing to the custom indexing function
	local indexer = indexer_match(self.real_table, key)
	if indexer then
		return indexer(self.real_table)
	end

	-- Default table behavior
	if not self.real_table[key] then
		return nil
	end

	return self.real_table[key]
end

function MI_META:__newindex(key, value)
	self.real_table[key] = value
end

-------------------
--    Wrapping   --
-------------------

mi = mi or {}

function mi.wrap(table)
	local wrapper = setmetatable({}, MI_META)
	rawset(wrapper, "real_table", table)

	return wrapper
end