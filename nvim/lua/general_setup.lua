vim.opt.background = "dark"
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- set copy paste
vim.opt.clipboard:append({ "unnamedplus" })

-- show line number
vim.opt.number = true

-- tab will add 4 spaces instead of a tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
