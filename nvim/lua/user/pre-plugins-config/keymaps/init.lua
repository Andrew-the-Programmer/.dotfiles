local M = {}

---@class Keymap
---@field mode string|table
---@field lhs string
---@field rhs string
---@field opts table
M.Keymap = {}

function M.Keymap:new(o)
    o = My.lua.IfNil(o, {})
    self.__index = self
    o = setmetatable(o, self)
    return o
end

function M.Keymap:Add()
    vim.keymap.set(self.mode, self.lhs, self.rhs, self.opts)
end

My.Keymap = M.Keymap

local vim_keymaps = require("user.pre-plugins-config.keymaps.vim")
local translation_keymaps = require("user.pre-plugins-config.keymaps.translation")

local keymaps = My.lua.CombineLists(translation_keymaps, vim_keymaps)

for _, keymap in ipairs(keymaps) do
    keymap:Add()
end

return M
