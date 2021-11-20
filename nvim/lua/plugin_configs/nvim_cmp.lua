local M = {}

function M.init()
	local cmp = require("cmp")

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args) end,
		},
		mapping = {
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "buffer" },
		}),
	})
end

return M
