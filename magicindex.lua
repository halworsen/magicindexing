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

-- Finds the indexer function for a key
local function get_indexer(table, key)
	-- match the specific word getkey with arbitrary case on each letter, optionally with underscore
	local pattern = "^[gG][eE][tT]_?"
	for i = 1,#key do
		local letter = string.sub(key, i, i)
		local letter_upper = string.upper(letter)
		pattern = pattern .. "[" .. letter .. letter_upper .. "]"
	end
	pattern = pattern .. "$"

	for k,v in pairs(table) do
		if string.match(k, pattern) then
			if v then
				return v
			end
		end
	end

	return nil
end

-------------------
-- Wrapper meta  --
-------------------

local MI_META = {}
MI_META.real_table = nil

function MI_META:__index(key)
	local real = rawget(self, "real_table")

	-- Pass off indexing to the custom indexing function
	local indexer = get_indexer(real, key)
	if indexer then
		return indexer(real)
	end

	-- Default table behavior
	return real[key]
end

function MI_META:__newindex(key, value)
	local real = rawget(self, "real_table")

	-- Metatable was applied without the wrapper function
	if not real then
		real = {}
		rawset(self, "real_table", real)
	end

	real[key] = value
end

-------------------
--    Wrapping   --
-------------------

local mi = {}

function mi.wrap(table)
	local wrapper = setmetatable({}, MI_META)
	rawset(wrapper, "real_table", table)

	return wrapper
end

return mi