local nvim_lsp = require("lspconfig")

local typescript = {
	flags = { debounce_text_changes = 150 },
	on_attach = function(client, bufnr)
		-- disable formatting because prettier will do it
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
}
nvim_lsp.tsserver.setup(typescript)

local golang = {
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
}
nvim_lsp.gopls.setup(golang)

nvim_lsp.eslint.setup({})

local rust = {
	checkOnSave = {
		overrideCommand = {
			"cargo",
			"clippy",
			"--workspace",
			"--message-format=json",
			"--all-targets",
			"--all-features",
		},
	},
}
nvim_lsp.rust_analyzer.setup(rust)
