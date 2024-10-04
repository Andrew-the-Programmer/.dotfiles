local vimconfig = "user.vim-config"

local M = {}

M.options = require(vimconfig .. ".options")
M.keymaps = require(vimconfig .. ".keymaps")
M.events = require(vimconfig .. ".events")
M.commands = require(vimconfig .. ".commands")
M.theme = require(vimconfig .. ".theme")

return M
