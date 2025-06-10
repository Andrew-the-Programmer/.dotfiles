local M = {}

local vim_keymaps = require("user.pre-plugins-config.keymaps.vim")
-- local translation_keymaps = require("user.filetype_specific.translation")

---@type Keymap[]
local keymaps = My.lua.CombineLists(vim_keymaps)

for _, keymap in ipairs(keymaps) do
	keymap:Add()
end

return M
