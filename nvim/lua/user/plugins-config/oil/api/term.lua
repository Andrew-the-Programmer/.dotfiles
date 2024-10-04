local Terminal = require("toggleterm.terminal").Terminal
local oil = require("oil")
local mtt = My.toggleterm

local M = {}

-- M.OilTerm = mtt.term.FloatTerm:new({
--     id = mtt.functions.GetUniqueTermId(),
-- })

M.OilTerm = Terminal:new({
    on_open = function(term)
        My.toggleterm.functions.Focuse(term)
    end,
    -- Need this
    -- See My.toggleterm.term.Term
    newline_chr = "\r",

    direction = "float",
    -- hidden = true,
    float_opts = {
        border = "double",
    },

    display_name = "OilTerm",
    id = mtt.functions.GetUniqueTermId(),
    count = mtt.functions.GetUniqueTermId(),
})

-- function M.OilTerm:new(opts)
-- 	local s = M.OilTerm
-- 	opts = opts or {}
-- 	setmetatable(opts, { __index = s })
-- 	return opts
-- end

-- This fixes the issue with open
-- When open it opens term with id 2, but term has the correct id
-- mtt.functions.LoadTerm(M.OilTerm)
-- M.OilTerm.open()
-- M.OilTerm.close()

-- setmetatable(M.OilTerm, { __index = mtt.term.FloatTerm })

-- print(M.OilTerm.id)

return M
