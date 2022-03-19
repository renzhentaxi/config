local keymap = require("my_plugins.keymap")
local M = {}
M.actions = {}

M.actions.status = keymap.action({ name = "git status", command = ":G<cr>", tags = "fugitive" })
M.actions.commit = keymap.action({ name = "git commit", command = ":G commit<cr>", tags = "fugitive" })
M.actions.blame = keymap.action({ name = "git blame", command = ":G blame<cr>", tags = "fugitive" })
M.actions.push = keymap.action({ name = "git push", command = ":G push ", tags = "fugitive" })

M.actions.push_force = keymap.action({
	name = "git push no-verify force",
	command = ":G push --no-verify --force-with-lease",
	tags = "fugitive",
})

return M
