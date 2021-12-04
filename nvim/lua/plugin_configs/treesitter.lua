local M = {}

function M.setup()
	print("hilo")
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
				init_selection = "gnn",
				-- visual
				node_incremental = "grn",
				-- visual
				scope_incremental = "grc",
				-- visual
				node_decremental = "grm",
			},
		},
	})
end

return M
