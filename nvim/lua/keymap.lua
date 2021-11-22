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

-- terminal
local cmd_escape_terminal = "<C-\\><C-n>"
map_key("t", "<leader><Esc>", cmd_escape_terminal)

local M = {}
function M.window_mode()
	local keys = { "h", "j", "k", "l" }
	local shouldStop = false
	while shouldStop == false do
		local c = vim.fn.getchar()
		if type(c) == "number" then
			c = vim.fn.nr2char(c)
		end
		if vim.tbl_contains(keys, c) then
			vim.api.nvim_command("wincmd " .. c)
			vim.cmd("redraw")
		else
			shouldStop = true
		end
	end
end

map_key("n", "<C-w>", '<cmd>lua require("keymap").window_mode()<CR>')

for _, key in ipairs({ "h", "j", "k", "l" }) do
	local keybind = "<A-" .. key .. ">"
	local action_cmd = "<C-w>" .. key
	map_key("t", keybind, cmd_escape_terminal .. action_cmd)
	map_key("n", keybind, action_cmd)
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
