vim.g.mapleader = " "

local keymap = require("my_plugins.keymap")

-- window_mode
local window_mode = require("my_plugins.window_mode")
keymap.map({ "n|t <leader><ESC>", "n <leader>w" }, window_mode.actions.enter)

-- utility
local utils = require("my_plugins.utils")

local function reload_my_plugins()
	for key, value in pairs(package.loaded) do
		if vim.startswith(key, "my_plugins") then
			utils.callIfExist(require(key), "teardown")
			package.loaded[key] = nil
			utils.callIfExist(require(key), "setup")
			print("reloaded " .. key)
		end
	end
end

keymap.map("n <leader>r", keymap.action({ name = "reload my_plugins", command = reload_my_plugins }))
-- remap
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
local fugitive = require("plugin_configs.fugitive")

keymap.map("n <leader>gs", fugitive.actions.status)
keymap.map("n <leader>gc", fugitive.actions.commit)
keymap.map("n <leader>gb", fugitive.actions.blame)
keymap.map("n <leader>gp", fugitive.actions.push)
keymap.map("n <leader>gpp", fugitive.actions.push_force)

-- lsp
--
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
