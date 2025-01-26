local M = {}

function M.IfNil(value, default)
    if value == nil then
        return default
    end
    return value
end

function M.Dump(o, opts)
	opts = opts or {}
	local sep = opts.sep or ", "
	local endl = opts.endl or "\n"
	-- Convert lua values to human readable string
	if type(o) ~= "table" then
		return tostring(o) .. endl
	end
	local s = "{" .. sep
	for k, v in pairs(o) do
		if type(k) ~= "number" then
			k = '"' .. k .. '"'
		end
		s = s .. "[" .. k .. "] = " .. M.Dump(v, { sep = sep, endl = "" }) .. sep
	end
	return s .. "}" .. endl
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

function M.Print(value, opts)
	print(M.Dump(value, opts))
end

function M.Require(module)
	-- require but loads even if loaded
	package.loaded[module] = nil
	return require(module)
end

function M.Surround(str, wrapper)
	return wrapper .. str .. wrapper
end

---@param opts table
---@param opts.cmd string
---@param opts.args string|table
---@param opts.input string
---@param opts.text string
---@return string
function M.GetCmd(opts)
	opts = opts or {}
	local cmd = opts.cmd
	local args = opts.args or ""
	if type(args) == "table" then
		args = table.concat(args, " ")
	end
	local input = opts.input or nil
	local text = opts.text or ""

	if not input then
		return cmd .. " " .. args .. " " .. My.lua.Surround(text, '"')
	end

	-- Has input

	local echo_cmd = M.GetCmd({ cmd = "echo", args = "-n", text = input })
	local cmd_s = M.GetCmd({ cmd = cmd, args = args, text = text })

	return echo_cmd .. " | " .. cmd_s
end

function M.EchoCmd(text, args)
	return M.GetCmd({ cmd = "echo", args = args, text = text })
end

---@param cmd string
---@return string
function M.GetCmdOutput(cmd)
	local vim_cmd = "silent exec " .. My.lua.Surround("!" .. cmd, "'")
	local output = vim.api.nvim_exec2(vim_cmd, { output = true })
	output = output["output"]
	local nl_pos = string.find(output, "\n")
	output = string.sub(output, nl_pos + 1, -1)
	output = string.gsub(output, "\n", "")
	return output
end

return M
