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

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
