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

return M
