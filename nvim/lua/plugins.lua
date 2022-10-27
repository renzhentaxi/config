-- my plugins

-- bootstrap
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

local packer = require("packer")
local use = packer.use

-- setup
packer.startup(function()
    use("wbthomason/packer.nvim")
    use({ "neovim/nvim-lspconfig", config = require("plugin_configs.lspconfig").setup })

    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    })

    use("L3MON4D3/LuaSnip")

    use({
        "hrsh7th/nvim-cmp",
        config = require("plugin_configs.nvim_cmp").setup,
        requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
    })

    use({
        "nvim-telescope/telescope-file-browser.nvim",
        requires = "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("plugin_configs.treesitter").setup,
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = require("plugin_configs.nullls").setup,
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    })

    use("tpope/vim-fugitive")
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    })

    use({ "nvim-lualine/lualine.nvim", config = require("plugin_configs.lualine").setup })
    -- themes
    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")
    use({
        "anuvyklack/hydra.nvim",
        config = function()
            local Hydra = require("hydra")
            local normal = vim.api.nvim_get_hl_by_name('Normal', true)
            local visual = vim.api.nvim_get_hl_by_name('Visual', true)
            local normalNc = vim.api.nvim_get_hl_by_name('NormalNC', true)
            Hydra({
                name = "Window",
                body = "<leader>w",
                config = {
                    invoke_on_body = true,
                    on_enter = function()
                        vim.api.nvim_set_hl(0, 'Normal', visual)
                        vim.api.nvim_set_hl(0, 'NormalNC', normal)
                    end,
                    on_exit = function()
                        vim.api.nvim_set_hl(0, 'Normal', normal)
                        vim.api.nvim_set_hl(0, 'NormalNC', normalNc)
                    end,
                },
                heads = {
                    { "h", "<C-w>h" },
                    { "j", "<C-w>j" },
                    { "k", "<C-w>k" },
                    { "l", "<C-w>l" },
                },
            })
        end,
    })
    use({ "williamboman/mason.nvim", config = require("plugin_configs.mason").setup })
    use({
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({ automatic_installation = true })
        end,
    })
end)
