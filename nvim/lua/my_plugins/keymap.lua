local utils = require("my_plugins.utils")
local M = {}

local default_opts = {
	noremap = true,
}

local actions = {}

function M.action(args)
	actions[args.name] = args
	return args
end

function M.command(args)
	local command_str = string.format("%s %s", args.command, args.command_args)
	return M.action({
		name = name or command_str,
		command = string.format("<cmd>%s<CR>", command_str),
	})
end

function M.lua(args)
	name = args.name or string.format("%s.%s", args.module_name, args.function_name)
	command_args = string.format('require("%s").%s()', args.module_name, args.function_name)

	return M.command({
		name = name,
		command = "lua",
		command_args = command_args,
	})
end

M.actions = actions

function M.map(keybind_with_mode, action, opts)
	modes, keybind = utils.split_once(keybind_with_mode, " ")
	modes = vim.split(modes, "|")
	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, keybind, action.command or action, opts or {})
	end
end

function M.map_command(keybind, command, command_args, opts)
	M.map(keybind, command({ command = command, command_args = command_args, opts = opts }), opts)
end

function M.map_lua_function(keybind, module_name, function_name, opts)
	M.map(keybind, M.lua({ module_name = module_name, function_name = function_name }), opts)
end

return M
