local oil = require("oil")

local oilconfig = "user.plugins-config.oil"

require(oilconfig .. ".functions")
require(oilconfig .. ".events")

local opts = require(oilconfig .. ".opts")
opts["keymaps"] = require(oilconfig .. ".keymaps")

oil.setup(opts)
