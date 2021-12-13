local M = {}

function M.setup()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.prettierd,
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.shfmt.with({
				filetypes = { "sh", "bash" },
			}),
		},
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

return M
