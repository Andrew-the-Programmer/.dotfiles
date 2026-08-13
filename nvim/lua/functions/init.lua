local M = {}

function M.update(...)
  local result = {}
  for _, t in ipairs({ ... }) do
    if not t then
      goto continue
    end
    for k, v in pairs(t) do
      if type(v) == "table" then
        result[k] = M.update(result[k], v)
      else
        result[k] = v
      end
    end
    ::continue::
  end
  return result
end

return M
