local M = {}

---@generic T,U
---@param value T
---@param default U
---@return T|U
function M.IfNil(value, default)
	return vim.F.if_nil(value, default)
end

---@param o table
---@param opts {sep: string, endl: string, indentation: integer}
function M.Dump(o, opts)
	opts = opts or {}
	local sep = opts.sep or ","
	local endl = opts.endl or "\n"
	local tab = "  "
	local indentation = opts.indentation or 0
	-- Convert lua values to human readable string
	if type(o) ~= "table" then
		return tostring(o)
	end
	local empty = true
	indentation = indentation + 1
	local s = "{" .. endl
	for k, v in pairs(o) do
		empty = false
		s = ("%s%s[%s] = %s%s%s"):format(
			s,
			string.rep(tab, indentation),
			tostring(k),
			M.Dump(v, {
				sep = sep,
				endl = endl,
				indentation = indentation + 1,
			}),
			sep,
			endl
		)
	end
	if empty then
		return "{}"
	end
	return s .. string.rep(tab, indentation - 2) .. "}"
end

---@param ... table
function M.CombineTables(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		for k, v in pairs(t) do
			result[k] = v
		end
	end
	return result
end

---@param ... table
function M.CombineLists(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		for _, v in pairs(t) do
			table.insert(result, v)
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

function M.Copy(t)
	local u = {}
	for k, v in pairs(t) do
		u[k] = v
	end
	return setmetatable(u, getmetatable(t))
end

---@param inputstr string
---@param sep string
---@return table
function M.Split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

---@param str string
---@param new_substring string
---@param si integer
---@param ei integer
function M.Substitute(str, new_substring, si, ei)
	local prefix = str:sub(1, si - 1)
	local suffix = str:sub(ei + 1)
	return prefix .. new_substring .. suffix
end

return M
