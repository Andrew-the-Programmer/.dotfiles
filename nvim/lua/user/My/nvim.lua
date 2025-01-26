local M = {}

function M.Notify(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

---@deprecated
function M.Execute(list_of_functions)
	list_of_functions = list_of_functions or {}

	if #list_of_functions == 0 then
		return
	end

	local first_func = table.remove(list_of_functions, 1)

	vim.defer_fn(function()
		first_func()
		M.Execute(list_of_functions)
	end, 0)
end

function M.GetBufFile(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	return file
end

function M.MakeBufExecutable(buf)
	local file = M.GetBufFile(buf)
	local cmd = "!chmod +x " .. My.lua.Surround(file, '"')
	vim.cmd(cmd)
end

---@param cmd string
function M.SilentExecCmdInBackground(cmd)
	vim.cmd("silent exec " .. My.lua.Surround("!tmux new -d " .. My.lua.Surround(cmd, '"'), "'"))
end

function M.GetCursorPos()
	local _, row, col = unpack(vim.fn.getpos("."))
	return row, col
end

---@deprecated
---@param cmd string
function M.InsertCmdOutput(cmd)
	vim.cmd("silent exec " .. My.lua.Surround("r!" .. cmd, "'"))
end

---@deprecated
---@param cmd string
---@param opts table | nil
function M.SetLineWithCmdOutput(cmd, opts)
	opts = opts or {}
	local line_number = opts.line_number or "."
	vim.cmd("silent exec " .. My.lua.Surround(line_number .. "!" .. cmd, "'"))
end

---@deprecated
---@param cmd string
---@param opts table | nil
function M.AppendCmdOutput(cmd, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line = vim.api.nvim_get_current_line()
	local cmd_l = My.lua.EchoCmd(line .. sep, "-n")
	cmd = cmd_l .. " && " .. cmd
	M.SetLineWithCmdOutput(cmd, opts)
end

---@param text string
---@param opts table | nil
---@param opts.line_number integer | nil
---@param opts.buffer integer | nil
function M.SetLine(text, opts)
	opts = opts or {}
    local row, _ = M.GetCursorPos()
	local line_number = opts.line_number or row
	local buffer = opts.buffer or 0
	local s = line_number - 1
	local f = line_number
	local lines = vim.api.nvim_buf_get_lines(buffer, s, f, true)
	lines[line_number - s] = text
	vim.api.nvim_buf_set_lines(buffer, s, f, true, lines)
end

---@param text string
---@param opts table | nil
---@param opts.line_number integer | nil after which line
---@param opts.buffer integer | nil
function M.InsertLine(text, opts)
	opts = opts or {}
    local row, _ = M.GetCursorPos()
	local line_number = opts.line_number or row
	local buffer = opts.buffer or 0
	local s = line_number - 1
	local f = line_number
	local lines = vim.api.nvim_buf_get_lines(buffer, s, f, true)
    table.insert(lines, line_number - s + 1, text)
	vim.api.nvim_buf_set_lines(buffer, s, f, true, lines)
end

---@param n integer
---@param opts table | nil
---@param buffer integer | nil
function M.GetLine(n, opts)
	opts = opts or {}
	local buffer = opts.buffer or 0
	local strict_indexing = opts.strict_indexing or true
	if n == 0 then
		return vim.api.nvim_get_current_line()
	end
	return vim.api.nvim_buf_get_lines(buffer, n - 1, n, strict_indexing)[1]
end

---@param text string
---@param opts table | nil
---@param opts.sep string | nil sep between current line and text
---@param opts.line_number integer | nil
---@param opts.buffer integer | nil
function M.AppendText(text, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line_number = opts.line_number or 0
	local line = M.GetLine(line_number)
	M.SetLine(line .. sep .. text, opts)
end

---@param text string
---@param opts table | nil
---@param opts.sep string | nil sep between current line and text
---@param opts.line_number integer | nil
---@param opts.buffer integer | nil
function M.PrependText(text, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line_number = opts.line_number or 0
	local line = M.GetLine(line_number)
	M.SetLine(text .. sep .. line, opts)
end

function M.PutText(text, opts)
	opts = opts or {}
	local how = opts.how or "nl"
	if how == "nl" then
		M.InsertLine(text, opts)
	elseif how == "a" then
		M.AppendText(text, opts)
	elseif how == "s" then
		M.SetLine(text, opts)
	end
end

--- Return the visually selected text as an array with an entry for each line
--- @return string[]|nil lines The selected text as an array of lines.
function M.get_visual_selection_text()
	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))

	-- visual line mode
	if vim.fn.mode() == "V" then
		if srow > erow then
			return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
		else
			return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
		end
	end

	-- regular visual mode
	if vim.fn.mode() == "v" then
		if srow < erow or (srow == erow and scol <= ecol) then
			-- NOTE: (ecol - 1) for chinese
			return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol - 1, {})
		else
			return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	end

	-- visual block mode
	if vim.fn.mode() == "\22" then
		local lines = {}
		if srow > erow then
			srow, erow = erow, srow
		end
		if scol > ecol then
			scol, ecol = ecol, scol
		end
		for i = srow, erow do
			table.insert(
				lines,
				vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
			)
		end
		return lines
	end
end

-- does not work
function M.EnterNormalMode()
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "n", true)
	-- vim.cmd("startinsert")
	-- vim.cmd("norm! i")
	-- vim.cmd("")
end

return M
