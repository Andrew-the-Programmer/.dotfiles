local mt = My.term
local mo = My.oil

local M = {}

---@class OilTerm : FloatTerm
M.OilTerm = mt.FloatTerm:new({
    display_name = "OilTerm",
})

function M.OilTerm:new(o)
    o = My.lua.IfNil(o, {})
    self.__index = self
    o.id = My.lua.IfNil(o.id, mt.GetUniqueTermId())
	o = setmetatable(o, self)
	return o
end

function M.OilTerm:OpenOil()
	local dir = self:GetCwd()
	self:Unfocus()
	mo.functions.OpenOil(dir)
end

function M.OilTerm:OpenFromOil()
	local dir = mo.functions.GetProperCwd()
	self:Open({ dir = dir })
end

---@param opts SendConfig|nil
function M.OilTerm:ExecuteFile(opts)
	local filepath = My.oil.functions.GetFullPathUnderCursor()
    mt.ExecuteFile(filepath, self, opts)
end

return M
