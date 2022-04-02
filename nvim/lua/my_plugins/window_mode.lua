local util = require("my_plugins.utils")
local M = {
	allowedKeys = util.string_to_char_table("<>-+=qhjklHJKLsvn"),
	namespace = {
		window = "window",
		size = "size",
	},
}

function M.execute(namespace, key) end

local function isKeyAllowed(c)
	return vim.tbl_contains(M.allowedKeys, c)
end

function M.enter()
	local before = "Normal"
	local after = "Visual"
	local current_background = util.get_highlight(before)
	local after_highlight = util.get_highlight(after)

	util.set_highlight(before, after_highlight)
	local c = util.get_char()
	while isKeyAllowed(c) do
		vim.api.nvim_command("wincmd " .. c)
		vim.cmd("redraw")
		c = util.get_char()
	end
	util.set_highlight(before, current_background)
end

function M.setup() end

-- actions
local keymap = require("my_plugins.keymap")
M.actions = {}

M.actions.enter = keymap.action({
	name = "Enter Window_mode",
	command = M.enter,
	tags = { "my_plugins", "window_mode" },
})

return M
