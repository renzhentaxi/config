local M = {}

function M.to_hex(rgb_number)
	return "#" .. bit.tohex(rgb_number, 6)
end

function M.get_highlight_background(name)
	local highlight = vim.api.nvim_get_hl_by_name(name, true)
	return M.to_hex(highlight.background)
end

function M.set_highlight_background(name, background)
	vim.cmd("highlight " .. name .. " guibg=" .. background)
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

return M
