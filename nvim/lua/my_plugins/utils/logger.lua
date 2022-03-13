local M = {}

function M.warn(error_message, context, stack_level)
	stack_level = stack_level or 0
	local stack = debug.getinfo(stack_level + 1)
	vim.api.nvim_echo({
		{ "[" .. context .. "] ", "Label" },
		{ error_message .. "\n", "WarningMsg" },
		{ "\tAt " .. stack.source .. " " .. stack.currentline .. "\n" },
	}, true, {})
end

return M
