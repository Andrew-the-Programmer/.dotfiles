local Terminal = require("toggleterm.terminal").Terminal
local mtt = My.toggleterm

local M = {}

M.Term = Terminal:new({
    display_name = "Term",
    id = mtt.functions.GetUniqueTermId(),
    count = mtt.functions.GetUniqueTermId(),
    on_open = function(term)
        My.toggleterm.functions.Focuse(term)
    end,
    -- Need this
    -- By default it is some other char
    -- But it doesn't execute cmd in term
    -- This one does, idk why
    newline_chr = "\r",
})
-- M.Term.__index = M.Term
-- setmetatable(M.Term, { __index = Terminal })
-- function M.Term:new(opts)
-- 	local s = M.Term
-- 	opts = opts or {}
-- 	setmetatable(opts, { __index = s })
-- 	return opts
-- end
function M.Term:new(opts)
    opts = opts or {}
    setmetatable(opts, { __index = self })
    return opts
end

-- mtt.functions.LoadTerm(M.Term)

M.FloatTerm = Terminal:new({
    on_open = function(term)
        My.toggleterm.functions.Focuse(term)
    end,
    -- Need this
    -- See My.toggleterm.term.Term
    newline_chr = "\r",

    display_name = "FloatTerm",
    id = mtt.functions.GetUniqueTermId(),
    count = mtt.functions.GetUniqueTermId(),
    direction = "float",
    -- hidden = true,
    float_opts = {
        border = "double",
    },
})

-- function M.FloatTerm:new(opts)
-- 	local s = M.FloatTerm
-- 	opts = opts or {}
-- 	setmetatable(opts, { __index = s })
-- 	return opts
-- end
function M.FloatTerm:new(opts)
    opts = opts or {}
    setmetatable(opts, { __index = self })
    return opts
end

-- mtt.functions.LoadTerm(M.FloatTerm)
-- M.FloatTerm.new = function(opts)
--     opts = opts or {}
--     setmetatable(opts, { __index = M.FloatTerm })
--     return opts
-- end
-- setmetatable(M.FloatTerm, { __index = M.Term })
-- function M.FloatTerm:new(o)
--     o = o or {}
--     setmetatable(o, self)
--     self.__index = self
--     return o
-- end

vim.keymap.set("n", "<leader>tt", function()
    mtt.functions.ReopenTerm(M.FloatTerm)
end, { desc = "Open float terminal" })

return M
