local utils = require("map_utils")
local lua_fn = utils.lua_fn

local M = {}

---@class Keymap
---@field mode string|string[]
---@field lhs string
---@field rhs string|fun()
---@field opts table|nil
M.Keymap = {}

---@alias KeymapTable { mode: string|string[], lhs: string, rhs: string|fun(), opts: table|nil}

---@param o KeymapTable
function M.Keymap:new(o)
	o = My.lua.IfNil(o, {})
	self.__index = self
	o = setmetatable(o, self)
	return o
end

function M.Keymap:Add()
	vim.keymap.set(self.mode, self.lhs, self.rhs, self.opts)
end

function M.Keymap:AddToBuffer(buf)
	buf = My.lua.IfNil(buf, 0)
	local mode = self.mode
	if type(mode) == "string" then
		mode = { self.mode }
	end
	for _, m in pairs(mode) do
		vim.api.nvim_buf_set_keymap(buf, m, self.lhs, lua_fn(self.rhs), self.opts)
	end
end

---@param keymaps_table KeymapsTable
---@return Keymap[]
function M.KeymapsTableToList(keymaps_table)
	---@type Keymap[]
	local keymaps_list = {}
	for lhs, value in pairs(keymaps_table) do
		local keymap = M.Keymap:new(value)
		keymap.lhs = lhs
		table.insert(keymaps_list, keymap)
	end
	return keymaps_list
end

return M
