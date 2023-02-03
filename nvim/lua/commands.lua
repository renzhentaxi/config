-- view config folder
vim.api.nvim_create_user_command("Config", function()
    require("telescope.builtin").find_files({ hidden = true, cwd = vim.fn.stdpath("config") })
end, {})
