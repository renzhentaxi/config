local logger = require("my_plugins.utils.logger")
local M = {}

-- if given a string, convert it to a list containing the str
-- if given a list, return list
-- else warn and return empty list
function M.as_list(str_or_list)
	local data_type = type(str_or_list)
	if data_type == "string" then
		return { str_or_list }
	end

	if data_type == "table" then
		return str_or_list
	end

	logger.warn("Unexpected type: " .. data_type .. " data " .. vim.inspect(str_or_list), "as_list")

	return {}
end

return M
