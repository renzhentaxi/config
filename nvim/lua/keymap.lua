local keymap = require("my_plugins.keymap")

vim.g.mapleader = " "

-- window_mode
keymap.map_action({ "n", "t" }, "<leader><Esc>", "window_mode.enter")
keymap.map_action({ "n" }, "<leader>w", "window_mode.enter")

-- utility
keymap.map(
	"n <leader>r",
	keymap.lua({
		name = "utils.reload_plugins",
		module_name = "my_plugins.utils",
		function_name = "reload",
	})
)

keymap.map("n <leader>s", keymap.action({ name = "save", command = ":w<cr>" }))
-- terminal
local cmd_escape_terminal = "<C-\\><C-n>"

for _, key in ipairs({ "h", "j", "k", "l" }) do
	local keybind = "<" .. "A" .. "-" .. key .. ">"
	local action_cmd = "<C-w>" .. key
	keymap.map("t " .. keybind, cmd_escape_terminal .. action_cmd)
	keymap.map("n " .. keybind, action_cmd)
end
-- fugitive
keymap.map("n <leader>gg", keymap.action({ name = "git status", command = ":G<cr>" }))

keymap.map("n <leader>gb", keymap.action({ name = "git blame", command = ":G blame<cr>" }))

-- telescope
local telescope_keys = {}

function telescope_keys.map(mapping, options)
	options = options or {}
	local mode = options.mode or "n"
	local prefix = options.prefix or "<leader>f"

	for keybind, action in pairs(mapping) do
		keybind = prefix .. keybind
		keymap.lua({
			name = "telescope." .. action,
			module_name = "telescope.builtin",
			function_name = action,
		})
		keymap.map_action("n", keybind, "telescope." .. action)
	end
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
