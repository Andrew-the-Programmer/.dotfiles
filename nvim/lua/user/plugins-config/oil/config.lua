local oil = require("oil")

local oilconfig = "user.plugins-config.oil"

require(oilconfig .. ".api")
require(oilconfig .. ".events")
require(oilconfig .. ".keymaps")

local opts = require(oilconfig .. ".opts")

oil.setup(opts)
