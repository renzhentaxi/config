function map_key(mode, lhs, rhs, options) 
	if options == nil then
		options = {}
	end
	if options.noremap  == nil then 
		options.noremap = true
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
vim.g.mapleader = ' '

-- terminal
map_key('t', '<leader><Esc>', '<C-\\><C-n>')

-- telescope
function telescope_map_key(mode, lhs, rhs, options)
    map_key(mode, '<leader>' .. lhs, "<cmd>lua require('telescope.builtin')." .. rhs .. '()<cr>', options)
end
telescope_map_key('n', 'f/', 'builtin')
telescope_map_key('n', 'ff', "find_files") 
telescope_map_key('n', 'fl', 'file_browser')

telescope_map_key('n', 'fs', "live_grep")
telescope_map_key('n', 'flb', "buffers")
telescope_map_key('n', 'flm', 'marks')

telescope_map_key('n', 'fg', 'git_branches')

telescope_map_key('n', 'fls', 'lsp_document_symbols')
telescope_map_key('n', 'flS', 'lsp_workspace_symbols')
telescope_map_key('n', 'flr', 'lsp_references')

telescope_map_key('n', 'fd', 'lsp_document_diagnostics')
telescope_map_key('n', 'fD', 'lsp_workspace_diagnostics')


-- nvim tree
map_key('n', '<C-n>', ':NvimTreeToggle<CR>')
