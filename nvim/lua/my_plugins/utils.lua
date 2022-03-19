local M = {}

M.str = require("my_plugins.utils.str")
M.logger = require("my_plugins.utils.logger")

function M.callIfExist(tbl, function_name)
	if type(tbl) ~= "table" then
		return
	end

	if tbl[function_name] ~= nil then
		tbl[function_name]()
	end
end

-- the rgb value given by nvim_get_hl_by_name is in the form of R + G * 256 + B * 256 * 256.
function M.to_hex(rgb_number)
	if type(rgb_number) == "number" then
		return "#" .. bit.tohex(rgb_number, 6)
	end
	return rgb_number
end

function M.get_highlight(name)
	local highlight = vim.api.nvim_get_hl_by_name(name, true)

	return {
		foreground = M.to_hex(highlight.foreground),
		background = M.to_hex(highlight.background),
	}
end

function M.set_highlight(name, highlight)
	local settings = {}

	if highlight.background then
		settings[#settings + 1] = "guibg=" .. highlight.background
	end
	if highlight.foreground then
		settings[#settings + 1] = "guifg=" .. highlight.foreground
	end
	if #settings > 0 then
		vim.cmd("highlight " .. name .. " " .. table.concat(settings, " "))
	end
end

function M.string_to_char_table(str)
	local char_table = {}
	for i = 1, string.len(str) do
		char_table[i] = string.sub(str, i, i)
	end
	return char_table
end

function M.get_char()
	local c = vim.fn.getchar()

	if type(c) == "number" then
		c = vim.fn.nr2char(c)
	end

	return c
end

-- throws error if object contains a field not in the allowed list
function M.check_for_unknown_fields(object, allowed_list, context)
	for k in pairs(object) do
		if not vim.tbl_contains(allowed_list, k) then
			M.logger.warn("warn: unexpected key " .. k, context, 3)
		end
	end
end

return M
