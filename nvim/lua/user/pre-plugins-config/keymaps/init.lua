local M = {}

local vim_keymaps = require("user.pre-plugins-config.keymaps.vim")
local translation_keymaps = require("user.pre-plugins-config.keymaps.translation")

---@type Keymap[]
local keymaps = My.lua.CombineLists(translation_keymaps, vim_keymaps)

for _, keymap in ipairs(keymaps) do
	keymap:Add()
end

return M
