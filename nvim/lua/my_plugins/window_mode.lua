local util = require("my_plugins.utils")
local M = {
	allowedKeys = util.string_to_char_table("<>-+=qhjklHJKLsvn"),
}

local function isKeyAllowed(c)
	return vim.tbl_contains(M.allowedKeys, c)
end

function M.enter()
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

function M.setup()
	local keymap = require("my_plugins.keymap")
	keymap.lua({
		name = "window_mode.enter",
		module_name = "my_plugins.window_mode",
		function_name = "enter",
	})
end
return M
