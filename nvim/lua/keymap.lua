local keymap = require("my_plugins.keymap")

function as_action(action)
	if type(action) == "string" then
		return { name = action, cmd = action }
	end
	return action
end

function map_key(mode, keybind, action)
	action = as_action(action)
	if action and action.cmd then
		vim.api.nvim_set_keymap(mode, keybind, action.cmd, { noremap = true })
	end
end

vim.g.mapleader = " "

keymap.map_lua_function("n <leader>w", "my_plugins.window_mode", "window_mode")
keymap.map_lua_function("n <leader>r", "my_plugins.utils", "reload")

-- terminal
local cmd_escape_terminal = "<C-\\><C-n>"

keymap.map("t <leader><Esc>", cmd_escape_terminal)

for _, key in ipairs({ "h", "j", "k", "l" }) do
	local keybind = "<" .. "A" .. "-" .. key .. ">"
	local action_cmd = "<C-w>" .. key
	keymap.map("t " .. keybind, cmd_escape_terminal .. action_cmd)
	keymap.map("n " .. keybind, action_cmd)
end

-- telescope
local telescope_keys = {}

function telescope_keys.map(mapping, options)
	options = options or {}
	local mode = options.mode or "n"
	local prefix = options.prefix or "<leader>f"

	for keybind, action in pairs(mapping) do
		action = as_action(action)

		keybind = prefix .. keybind
		keymap.map_lua_function(mode .. " " .. keybind, "telescope.builtin", action.cmd)
	end
end

function telescope_keys.action(action_name)
	return "<cmd>lua require('telescope.builtin')." .. action_name .. "()<cr>"
end

telescope_keys.map({
	["?"] = "builtin",

	lb = "buffers",
	lx = "marks",

	c = "commands",
	s = "live_grep",
	h = "help_tags",

	gb = "git_branches",
	gc = "git_commits",
	gs = "git_status",

	ls = "lsp_document_symbols",
	lS = "lsp_workspace_symbols",

	lD = "ls_implementations",
	lt = "lsp_type_definitions",

	li = "lsp_document_diagnostics",
	lI = "lsp_workspace_diagnostics",
})

telescope_keys.map({
	p = "find_files",
	["/"] = "current_buffer_fuzzy_find",
	gd = "lsp_definitions",
	gr = "lsp_references",
	a = "lsp_code_actions",
}, { prefix = "<leader>" })

return M
