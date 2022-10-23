local telescope = require("telescope.")
local builtins = require("telescope.builtin")

local keymap = require("my_plugins.keymap")
local m = {}

m.actions = {}

local function create_telescope_action(builtin_name)
	return keymap.action({ name = "telescope." .. builtin_name, command = builtins[builtin_name] })
end

m.actions.diagnostics = create_telescope_action("diagnostics")
m.actions.live_grep = create_telescope_action("live_grep")
m.actions.current_buffer_tags = create_telescope_action("current_buffer_tags")
m.actions.git_files = create_telescope_action("git_files")
m.actions.git_branches = create_telescope_action("git_branches")
m.actions.tags = create_telescope_action("tags")
m.actions.git_bcommits = create_telescope_action("git_bcommits")
m.actions.git_status = create_telescope_action("git_status")
m.actions.tagstack = create_telescope_action("tagstack")
m.actions.git_stash = create_telescope_action("git_stash")
m.actions.lsp_workspace_symbols = create_telescope_action("lsp_workspace_symbols")
m.actions.pickers = create_telescope_action("pickers")
m.actions.planets = create_telescope_action("planets")
m.actions.oldfiles = create_telescope_action("oldfiles")
m.actions.loclist = create_telescope_action("loclist")
m.actions.search_history = create_telescope_action("search_history")
m.actions.find_files = create_telescope_action("find_files")
m.actions.man_pages = create_telescope_action("man_pages")
m.actions.reloader = create_telescope_action("reloader")
m.actions.registers = create_telescope_action("registers")
m.actions.autocommands = create_telescope_action("autocommands")
m.actions.resume = create_telescope_action("resume")
m.actions.highlights = create_telescope_action("highlights")
m.actions.commands = create_telescope_action("commands")
m.actions.lsp_implementations = create_telescope_action("lsp_implementations")
m.actions.symbols = create_telescope_action("symbols")
m.actions.lsp_dynamic_workspace_symbols = create_telescope_action("lsp_dynamic_workspace_symbols")
m.actions.buffers = create_telescope_action("buffers")
m.actions.lsp_document_symbols = create_telescope_action("lsp_document_symbols")
m.actions.treesitter = create_telescope_action("treesitter")
m.actions.lsp_type_definitions = create_telescope_action("lsp_type_definitions")
m.actions.lsp_definitions = create_telescope_action("lsp_definitions")
m.actions.lsp_references = create_telescope_action("lsp_references")
m.actions.jumplist = create_telescope_action("jumplist")
m.actions.spell_suggest = create_telescope_action("spell_suggest")
m.actions.filetypes = create_telescope_action("filetypes")
m.actions.vim_options = create_telescope_action("vim_options")
m.actions.grep_string = create_telescope_action("grep_string")
m.actions.fd = create_telescope_action("fd")
m.actions.git_commits = create_telescope_action("git_commits")
m.actions.help_tags = create_telescope_action("help_tags")
m.actions.quickfix = create_telescope_action("quickfix")
m.actions.command_history = create_telescope_action("command_history")
m.actions.keymaps = create_telescope_action("keymaps")
m.actions.builtin = create_telescope_action("builtin")
m.actions.current_buffer_fuzzy_find = create_telescope_action("current_buffer_fuzzy_find")
m.actions.colorscheme = create_telescope_action("colorscheme")
m.actions.marks = create_telescope_action("marks")

-- check for new pickers
for name, _ in pairs(builtins) do
	if m.actions[name] == nil then
		print("new plugin:", name)
	end
end

m.actions.file_browser = keymap.action({
	name = "telescope.file_browser",
	command = telescope.extensions.file_browser.file_browser,
})

return m
