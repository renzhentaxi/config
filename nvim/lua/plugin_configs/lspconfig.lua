local m = {}

function m.setup()
	local lsp = require("lspconfig")
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	lsp.sumneko_lua.setup({
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
end
return m
