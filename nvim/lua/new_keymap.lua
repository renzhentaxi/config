vim.g.mapleader = " "

-- save
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- open neotree
vim.keymap.set("n", "\\", ":Neotree reveal toggle left<CR>")

-- fuzzy find files
vim.keymap.set("n", "<leader>p", function()
	require("telescope.builtin").find_files()
end)

-- diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>D", vim.diagnostic.goto_prev)

vim.keymap.set("n", "<leader>fd", function()
	require("telescope.builtin").diagnostics()
end)
