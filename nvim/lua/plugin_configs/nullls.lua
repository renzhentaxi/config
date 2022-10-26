local M = {}

function M.setup()
	local augroup = vim.api.nvim_create_augroup("TaxiLspFormatting", {})
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.prettierd,
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.shfmt.with({
				filetypes = { "sh", "bash" },
			}),
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end,
	})
end

return M
