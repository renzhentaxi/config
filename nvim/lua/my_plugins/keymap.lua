local utils = require("my_plugins.utils")
local M = {}
local actions = {}
M.actions = actions

-- name: the name for this action
-- desc: description for this action
-- command: either a string or a lua function that will be executed
-- tags: a list of tags
-- unknown properties will be an error
function M.action(args)
	utils.check_for_unknown_fields(args, { "name", "desc", "command", "tags" }, "keymap.action")
	if actions[args.name] ~= nil then
		print("keymap.action: multiple actions with name", args.name)
	end
	actions[args.name] = args
	return args
end

local function map_single(keybind_with_mode, action, opts)
	local modes, keybind = utils.str.split_once(keybind_with_mode, " ")
	modes = vim.split(modes, "|")
	vim.keymap.set(modes, keybind, action.command or action, opts or {})
end

function M.map(keybind_with_mode, action, opts)
	local as_list = utils.str.as_list(keybind_with_mode)
	for _, keybind in ipairs(as_list) do
		map_single(keybind, action, opts)
	end
end

return M
