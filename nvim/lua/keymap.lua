--local wk = require("which-key")

function map_key(mode, lhs, rhs, name)
	if rhs ~= nil then
		-- wk.register({
		-- 	[lhs] = { rhs, name },
		-- }, { mode = mode })
		vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
	else
		-- wk.register({
		-- 	[lhs] = { name = name },
		-- })
	end
end

vim.g.mapleader = " "

-- terminal
map_key("t", "<leader><Esc>", "<C-\\><C-n>")

-- telescope
local telescope_keys = {}

function telescope_keys.map(mapping, options)
	options = options or {}
	local mode = options.mode or "n"
	local prefix = options.prefix or "<leader>f"

	for keybind, action in pairs(mapping) do
		if type(action) == "string" then
			action = { name = action, cmd = action }
		end

		keybind = prefix .. keybind
		if action.cmd ~= nil then
			action.cmd = telescope_keys.action(action.cmd)
		end
		map_key(mode, keybind, action.cmd, action.name)
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
