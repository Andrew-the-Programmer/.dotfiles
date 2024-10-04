local M = {}

My = {}

My = require("user.My")
M.pre_plugins = require("user.pre-plugins-config")
require("user.lazy_plugins_init")
M.plugins_config = require("user.plugins-config")
M.src = require("user.src")
M.vim_config = require("user.vim-config")

return M
