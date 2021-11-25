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

map_key("n", "<leader>w", '<cmd>lua require("my_plugins.window_mode").window_mode()<CR>')

-- terminal
local cmd_escape_terminal = "<C-\\><C-n>"
map_key("t", "<leader><Esc>", cmd_escape_terminal)

for _, key in ipairs({ "h", "j", "k", "l" }) do
	local keybind = "<A-" .. key .. ">"
	local action_cmd = "<C-w>" .. key
	map_key("t", keybind, cmd_escape_terminal .. action_cmd)
	map_key("n", keybind, action_cmd)
end

map_key("n", "<leader>r", '<cmd>lua require("my_plugins.window_mode").reload()<CR>')
-- telescope
local telescope_keys = {}

function telescope_keys.map(mapping, options)
	options = options or {}
	local mode = options.mode or "n"
	local prefix = options.prefix or "<leader>f"

	for keybind, action in pairs(mapping) do
		action = as_action(action)

		keybind = prefix .. keybind
		if action.cmd ~= nil then
			action.cmd = telescope_keys.action(action.cmd)
		end

		map_key(mode, keybind, action)
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

	g = { name = "git" },
	gb = "git_branches",
	gc = "git_commits",
	gs = "git_status",
	l = { name = "lsp" },

	ls = "lsp_document_symbols",
	lS = "lsp_workspace_symbols",

	lr = "lsp_references",
	ld = "lsp_definitions",
	lD = "ls_implementations",
	lt = "lsp_type_definitions",

	la = "lsp_code_actions",
	li = "lsp_document_diagnostics",
	lI = "lsp_workspace_diagnostics",
})

telescope_keys.map({ p = "find_files", ["/"] = "current_buffer_fuzzy_find" }, { prefix = "<leader>" })

-- nvim tree
map_key("n", "<C-n>", ":NvimTreeToggle<CR>")

return M
