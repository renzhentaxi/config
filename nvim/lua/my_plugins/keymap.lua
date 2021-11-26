local utils = require("my_plugins.utils")
local M = {}

M.keymaps = {}
local default_opts = {
	noremap = true,
}

local actions = {}

function actions.command(name, command, command_args)
	local command_str = string.format("%s %s", command, command_args)
	return {
		name = name or command_str,
		command = string.format("<cmd>%s<CR>", command_str),
	}
end

function actions.lua_function(name, module_name, function_name)
	name = name or string.format("%s.%s", module_name, function_name)
	command_args = string.format('require("%s").%s()', module_name, function_name)
	return actions.command(name, "lua", command_args)
end

M.actions = actions

function M.map(keybind_with_mode, action, opts)
	mode, keybind = utils.split_once(keybind_with_mode, " ")

	vim.api.nvim_set_keymap(mode, keybind, action.command or action, opts or {})
end

function M.map_command(keybind, command, command_args, opts)
	M.map(keybind, actions.command(command, command_args), opts)
end

function M.map_lua_function(keybind, module_name, function_name, opts)
	M.map(keybind, actions.lua_function("", module_name, function_name), opts)
end

-- keymap function(action)
--      action("")::lua(module, fn)::bind("name")
-- end
return M
