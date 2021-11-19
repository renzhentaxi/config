local nvim_lsp = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local typescript = {
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
	on_attach = function(client, bufnr)
		-- disable formatting because prettier will do it
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
}

nvim_lsp.tsserver.setup(typescript)
nvim_lsp.eslint.setup({})
