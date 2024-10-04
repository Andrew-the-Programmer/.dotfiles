-- local module = "user.plugins-config.toggleterm."
--
-- require(module .. "config")
-- require(module .. "functions")
--
-- require(module .. "lazygit")
-- require(module .. "execute")

My.toggleterm = {}

-- M.constants = require("user.plugins-config.toggleterm.constants")
My.toggleterm.constants = require("user.plugins-config.toggleterm.constants")
My.toggleterm.functions = require("user.plugins-config.toggleterm.functions")
My.toggleterm.config = require("user.plugins-config.toggleterm.config")

My.toggleterm.term = require("user.plugins-config.toggleterm.term")
My.toggleterm.lazygit = require("user.plugins-config.toggleterm.lazygit")
My.toggleterm.execute = require("user.plugins-config.toggleterm.execute")

return My.toggleterm
