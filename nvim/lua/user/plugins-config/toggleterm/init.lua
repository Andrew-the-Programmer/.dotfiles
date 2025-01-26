My.toggleterm = {}

My.toggleterm.functions = require("user.plugins-config.toggleterm.functions")
My.toggleterm.term = require("user.plugins-config.toggleterm.term_class")
My.toggleterm.terms = require("user.plugins-config.toggleterm.terms")

My.term = My.lua.CombineTables(
    My.toggleterm.term,
    My.toggleterm.terms,
    My.toggleterm.functions
)

require("user.plugins-config.toggleterm.config")
require("user.plugins-config.toggleterm.keymaps")

return My.term
