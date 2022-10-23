vim.g.mapleader = " "

local keymap = require("my_plugins.keymap")

-- window_mode
local window_mode = require("my_plugins.window_mode")
keymap.map({ "n|t <leader><ESC>", "n <leader>w" }, window_mode.actions.enter)

-- utility
local utils = require("my_plugins.utils")

local function reload_my_plugins()
	for key, _ in pairs(package.loaded) do
		if vim.startswith(key, "my_plugins") then
			utils.callIfExist(require(key), "teardown")
			package.loaded[key] = nil
			utils.callIfExist(require(key), "setup")
			print("reloaded " .. key)
		end
	end
end
-- keymap.map("n <leader>r", keymap.action({ name = "reload my_plugins", command = reload_my_plugins }))

-- quickfix
keymap.map("n ]q", keymap.action({ name = "quickfix next", command = ":cn<CR>" }))
keymap.map("n [q", keymap.action({ name = "quickfix prev", command = ":cp<CR>" }))

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
keymap.map("n <leader>gpP", fugitive.actions.push_force)
keymap.map("n <leader>gpp", fugitive.actions.push_no_verify)

-- lsp
keymap.map("n <leader>r", keymap.action({ name = "rename", command = vim.lsp.buf.rename }))

-- telescope

local telescope = require("plugin_configs.telescope")

keymap.map("n <leader>ld", telescope.actions.diagnostics)
-- keymap.map("n <leader>la", telescope.actions.lsp_code_actions) use vim.lsp.buf.code_action
keymap.map("n <leader>ls", telescope.actions.lsp_document_symbols)
keymap.map("n <leader>lS", telescope.actions.lsp_workspace_symbols)

keymap.map("n <leader>lx", telescope.actions.marks)
keymap.map("n <leader>lb", telescope.actions.buffers)
keymap.map("n <leader>lr", telescope.actions.registers)

keymap.map("n <leader>p", telescope.actions.find_files)
keymap.map("n <leader>P", telescope.actions.live_grep)

keymap.map("n <leader>gd", telescope.actions.lsp_definitions)
keymap.map("n <leader>gi", telescope.actions.lsp_implementations)
keymap.map("n <leader>gr", telescope.actions.lsp_references)
keymap.map("n <leader>gt", telescope.actions.lsp_type_definitions)

keymap.map("n <leader>/", telescope.actions.current_buffer_fuzzy_find)
keymap.map("n <leader>f", telescope.actions.file_browser)
-- trouble

keymap.map(
	"n <leader>ga",
	keymap.action({
		name = "trouble diagnostics",
		command = ":TroubleToggle<CR>",
	})
)

return M
