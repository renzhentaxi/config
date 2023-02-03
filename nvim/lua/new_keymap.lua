vim.g.mapleader = " "

-- save
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- open neotree
vim.keymap.set("n", "\\", ":Neotree reveal toggle left<CR>")

-- fuzzy find files
vim.keymap.set("n", "<leader>p", function()
	require("telescope.builtin").find_files()
end)
