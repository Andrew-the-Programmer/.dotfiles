local mt = My.toggleterm

local M = {}

---@class FloatTerm : Term
M.FloatTerm = mt.term.Term:new({
    display_name = "FloatTerm",
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function M.FloatTerm:new(o)
    o = My.lua.IfNil(o, {})
    self.__index = self
    o.id = My.lua.IfNil(o.id, mt.functions.GetUniqueTermId())
    o = setmetatable(o, self)
    return o
end

---@class TermExecute : FloatTerm
M.TermExecute = M.FloatTerm:new({
    display_name = "TermExecute",
})

function M.TermExecute:new(o)
    o = My.lua.IfNil(o, {})
    self.__index = self
    o.id = My.lua.IfNil(o.id, mt.functions.GetUniqueTermId())
    o = setmetatable(o, self)
    return o
end

---@param file string
---@param term Term
---@param opts SendConfig|nil
function M.ExecuteFile(file, term, opts)
    ---@type Term
    term = My.lua.IfNil(term, M.TermExecute)
    local nil_opts = (opts == nil)
    opts = opts or mt.term.SendConfig:new()
    if nil_opts then
        opts.execute = false
    end
    local dir = vim.fn.fnamemodify(file, ":p:h")
    term:Open({ dir = dir })
    term:Send(file, opts)
end

---@param opts SendConfig|nil
function M.ExecuteBuffer(opts, term)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    M.ExecuteFile(file, term, opts)
end

return M
