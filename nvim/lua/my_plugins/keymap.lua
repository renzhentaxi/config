local utils = require("my_plugins.utils")
local M = {}

local default_opts = {
	noremap = true,
}

local actions = {}

-- name: the name for this action
-- desc: description for this action
-- command: either a string or a lua function that will be executed
-- tags: a list of tags
-- unknown properties will be an error
function M.action(args)
	utils.check_for_unknown_fields(args, { "name", "desc", "command", "tags" }, "keymap.action")
	actions[args.name] = args
	return args
end

-- name
-- command
-- command_args
function M.command(args)
	local command_str = string.format("%s %s", args.command, args.command_args)
	return M.action({
		name = name or command_str,
		command = string.format("<cmd>%s<CR>", command_str),
	})
end

-- name
-- module_name
-- function_name
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

function M.map_action(modes, keybind, action_name)
	if actions[action_name] ~= nil then
		modes = utils.str.as_list(modes)
		action = actions[action_name]
		for i, mode in ipairs(modes) do
			vim.api.nvim_set_keymap(mode, keybind, action.command, { noremap = action.noremap })
		end
	else
		print(string.format("Unknown action: %s", action_name))
		print(vim.inspect(actions))
	end
end

local function map_single(keybind_with_mode, action, opts)
	modes, keybind = utils.split_once(keybind_with_mode, " ")
	modes = vim.split(modes, "|")
	vim.keymap.set(modes, keybind, action.command or action, opts or {})
end

function M.map(keybind_with_mode, action, opts)
	local as_list = utils.str.as_list(keybind_with_mode)
	for i, keybind in ipairs(as_list) do
		map_single(keybind, action, opts)
	end
end

return M
