local M = {}

--- Check if a table contains a string
--- @param table table The table to search in
--- @param query string The value to search for
--- @return boolean found true if the value is found, false otherwise
function M.contains(table, query)
	for _, v in ipairs(table) do
		if v == query then return true end
	end
	return false
end

--- Get the next value in a table after the current value, cycling to the first if at the end
--- If applied to an array, returns the next value
--- If applied to a table, returns the next key
--- @param values table The table of values to cycle through
--- @param current any The current value to find the next one for
--- @return any next The next value in the table, or the first key of values if current is not found
function M.next(values, current)
	-- is array
	if #values > 0 then
		for i, v in ipairs(values) do
			if v == current then
				return values[(i % #values) + 1]
			end
		end
		return values[1]
	end

	-- otherwise is table
	local keys = {}
	for k in pairs(values) do
		table.insert(keys, k)
	end

	for i, k in ipairs(keys) do
		if k == current then
			return keys[(i % #keys) + 1]
		end
	end
	return keys[1] -- default to the first element
end

return M
