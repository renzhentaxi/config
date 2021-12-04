local M = {}

function M.setup()
	local cmp = require("cmp")
	local function tab_complete_next(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end
	local function tab_complete_previous(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		end
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(tab_complete_next, { "i" }),
			["<S-Tab>"] = cmp.mapping(tab_complete_previous, { "i" }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
		preselect = cmp.PreselectMode.None,
	})
end

return M
