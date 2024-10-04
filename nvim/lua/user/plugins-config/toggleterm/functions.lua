local tt = require("toggleterm")
local ui = require("toggleterm.ui")
local mtt = My.toggleterm
-- local oil = require("oil")
local terminal = require("toggleterm.terminal")
local Terminal = terminal.Terminal

local M = {}

function M.LoadTerm(term)
	term:open()
	term:close()
end

function M.GetTerm(term_id)
	return tt.get(term_id)
end

local __term_count = 0
function M.GetUniqueTermId()
	__term_count = __term_count + 1
	return __term_count
end

function M.GetTermByBufnr(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local all = terminal.get_all(true)
	for _, term in pairs(all) do
		if term.bufnr == bufnr then
			return term
		end
	end
end

---Focus on given terminal
---@param term Terminal
function M.Focuse(term)
	term:focus()
	vim.cmd("startinsert!")
end

function M.Unfocuse()
	ui.goto_previous()
	ui.stopinsert()
end

function M.ExecTermCmd(cmd, term_count)
	term_count = term_count or 1
	return tt.exec(cmd, term_count, 12)
end

function M.ExecBuf(buf, term_count)
	buf = buf or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	return M.ExecTermCmd(file, term_count)
end

function M.ExecTermCmds(cmds, term_count)
	cmds = cmds or {}
	for _, cmd in pairs(cmds) do
		M.ExecTermCmd(cmd, term_count)
	end
end

local function GetProperCwd()
	local cwd = vim.fn.getcwd()
	return cwd
end

---Toggle term, account oil and vim cwd
---@param term Terminal
---@param opts table {dir: string}
function M.OpenTerm(term, opts)
	-- print(term.id)
	if term:is_open() then
		return
	end
	opts = opts or {}
	local cwd = opts.dir or GetProperCwd()
	term:open()
	-- TODO: fix: term dont cd on reopen
	term:change_dir(cwd)
end

---Close term
---@param term Terminal
function M.CloseTerm(term)
	term:close()
end

---Toggle term, account oil and vim cwd
---@param term Terminal
---@param opts table {dir: string}
function M.ToggleTerm(term, opts)
	if term:is_open() then
		M.CloseTerm(term)
		return
	end
	M.OpenTerm(term, opts)
end

---Reopen term, account oil and vim cwd
---@param term Terminal
---@param opts table {dir: string}
function M.ReopenTerm(term, opts)
	M.CloseTerm(term)
	M.OpenTerm(term, opts)
end

---Combine arguments into strings separated by new lines
---@param newline_chr string
---@param args string|string[]
---@return string
local function with_cr(newline_chr, args)
	if type(args) == "string" then
		return args .. newline_chr
	end
	local result = {}
	for _, str in ipairs(args) do
		table.insert(result, with_cr(newline_chr, str))
	end
	return table.concat(result, "")
end

---Send a command to a running terminal but don't execute
---@param term Terminal
---@param cmd string|string[]
---@param opts table|nil {go_back: boolean, ask_input: boolean, newline_chr: string}
function M.Send(term, cmd, opts)
	opts = opts or {}
	local go_back = opts.go_back or false
	local ask_input = opts.ask_input or false
	local newline_chr = opts.newline_chr or term.newline_chr
	if ask_input then
		newline_chr = " "
	end

	cmd = with_cr(newline_chr, cmd)
	vim.fn.chansend(term.job_id, cmd)
	term:scroll_bottom()
	if go_back and term:is_focused() then
		M.Unfocuse()
	elseif not go_back and not term:is_focused() then
		M.Focuse(term)
	end
end

function M.SaveTermCwd(term)
	local file = mtt.constants.TERM_CWD_FILE
	M.Send(term, "pwd > " .. file)
end

function M.GetSavedTermCwd()
	local file = mtt.constants.TERM_CWD_FILE
	local cwd = My.sys.ReadFile(file)
	return cwd
end

function M.Clear(term)
	M.Send(term, "\21", { newline_chr = "" })
	term:clear()
end

function M.EnterNormalModeInTerm(term)
	M.Send(term, "\27", { newline_chr = "" })
end

return M
