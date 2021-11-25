local util = require("my_plugins.utils")

local M = {
	allowedKeys = util.string_to_char_table("<>-+=qhjklHJKLsvn"),
}

local function isKeyAllowed(c)
	return vim.tbl_contains(M.allowedKeys, c)
end

function M.window_mode()
	local current_background = util.get_highlight_background("Normal")
	local visual_background = util.get_highlight_background("Visual")

	util.set_highlight_background("Normal", visual_background)
	local c = util.get_char()
	while isKeyAllowed(c) do
		vim.api.nvim_command("wincmd " .. c)
		vim.cmd("redraw")
		c = util.get_char()
	end
	util.set_highlight_background("Normal", current_background)
end

function M.reload()
	for key, value in pairs(package.loaded) do
		if vim.startswith(key, "my_plugins") then
			package.loaded[key] = nil
		end
	end
	package.loaded["my_plugins.window_mode"] = nil
end

return M
