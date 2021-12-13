local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "bash", "rust", "go", "lua", "python", "scss", "typescript" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				-- normal
				init_selection = "<Enter>",
				-- visual
				node_incremental = "<Enter>",
				-- visual
				scope_incremental = "<TAB>",
				-- visual
				node_decremental = "<S-TAB>",
			},
		},
	})
end

return M
