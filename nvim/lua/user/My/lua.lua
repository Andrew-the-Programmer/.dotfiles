local M = {}

function M.Dump(o)
	-- Convert lua values to human readable string
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.Dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function M.CombineTables(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		for k, v in pairs(t) do
			result[k] = v
		end
	end
	return result
end

function M.Print(value)
	print(M.Dump(value))
end

function M.Require(module)
	-- require but loads even if loaded
	package.loaded[module] = nil
	return require(module)
end

function M.Surround(str, wrapper)
	return wrapper .. str .. wrapper
end

return M
