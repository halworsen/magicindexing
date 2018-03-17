dofile("magicindex.lua")

local test_table = mi.wrap({
	["foo"] = 5,
	["bar"] = 3
})

function test_table:getFoo()
	return (self.foo + 1)
end

function test_table:get_bar()
	self.bar = self.bar - 2

	return self.bar
end

function test_table:GetBaz()
	if self.bar == 3 then
		return "original ("..rawget(self, "bar")..")"
	elseif self.bar == 1 then
		return "bar was indexed ("..rawget(self, "bar")..")"
	end
end

print(test_table.baz)
print(test_table.foo)
print(test_table.bar)
print(test_table["baz"])
print(test_table["foo"])
print(test_table.unset_key)

test_table.normal_key = "all's well"
print(test_table.normal_key)