local mtt = My.toggleterm
local execute_cmd = mtt.execute.execute_cmd
local oil = require("oil")

local M = {}

local function GetProperCwd()
	local cwd = vim.fn.getcwd()
	if vim.bo.filetype == "oil" then
		cwd = oil.get_current_dir()
		if cwd == nil then
			error("Could not get oil cwd")
		end
	end
	return cwd
end

---@param oilbuf integer oil buffer
function M.OpenTerm(oilbuf)
	oilbuf = oilbuf or vim.api.nvim_get_current_buf()
	mtt.functions.OpenTerm(My.oil.term.OilTerm, { dir = GetProperCwd() })
end

---@param cmd string|string[]
---@param opts table See Send.
function M.ExecuteCmd(cmd, opts)
	return execute_cmd(cmd, opts)
end

function M.GetFilenameUnderCursor()
	local entry = oil.get_cursor_entry()
	if not entry then
		return
	end
	local filename = entry.name
	return filename
end

function M.GetShortPathUnderCursor()
	local filename = M.GetFilenameUnderCursor()
	return "./" .. filename
end

function M.GetFullPathUnderCursor()
	local filename = M.GetFilenameUnderCursor()
	local cwd = oil.get_current_dir()
	return cwd .. filename
end

function M.OpenOil(dir)
	vim.cmd("Oil " .. dir)
end

function M.OpenOilInNvimCwd()
	local cwd = vim.fn.getcwd()
	M.OpenOil(cwd)
end

function M.OpenOilInTermCwd()
	local cwd = mtt.functions.GetSavedTermCwd()
	mtt.functions.Unfocuse()
	M.OpenOil(cwd)
end

return M
