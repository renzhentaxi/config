local M = {}
function M.setup()
	local output = vim.api.nvim_exec("highlight", true)
	--print(string.len(output))
	print("setup")
end

function M.teardown()
	print("teardown")
end

function M.go()
	require("telescope.builtin").find_files()
end
vim.api.nvim_set_keymap("n", "<leader>j", ":lua require('my_plugins.hl_finder').go()<cr>", { noremap = true })
return M
