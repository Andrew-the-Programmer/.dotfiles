local M = {}

function M.BufIsTerm()
	return vim.bo.buftype == "terminal"
end

function M.ErrIfNotInTerm()
	if M.BufIsTerm() then
		return
	end
	error("Not in a terminal buffer")
end

function M.FeedInput(string)
	local key = vim.api.nvim_replace_termcodes(string, true, false, true)
	M.Execute({
		function()
			vim.cmd.startinsert()
		end,
		function()
			vim.api.nvim_feedkeys(key, "i", false)
		end,
	})
end

function M.ExecTermCmd(cmd)
	M.FeedInput(cmd .. "<CR>")
end

function M.ExecTermCmds(cmds)
	for _, cmd in pairs(cmds) do
		M.ExecTermCmd(cmd)
	end
end

function M.OpenTerm(t)
	--[[
    t = {
        pos="f",
        shell="zsh",
        cmds={},
        prefix="15sp",
        tcmd="term://"
    }
    --]]

	t = t or {}
	setmetatable(t, { __index = { pos = "f", shell = "zsh", cmds = {}, prefix = "15sp", tcmd = "term://" } })

	local args = { t.prefix, t.tcmd, t.shell }
	local execcmd = table.concat(args, " ")

	M.Execute({
		function()
			vim.cmd(execcmd)
		end,
		function()
			M.ExecTermCmds(t.cmds)
			vim.cmd.startinsert()
		end,
	})
end

function M.CloseTerm()
	vim.cmd("bd!")
end

M.Detail = {}
M.Detail.dir = nil

function M.GetTermCwd()
	-- local dir = "<>"
	-- Detail.dir = "<>"

	-- return My.Execute({
	--     function()
	--         My.ExecTermCmd("pwd | xclip -selection clipboard")
	--     end,
	--     function()
	--         My.Detail.dir = vim.fn.getreg("+")
	--         -- print("dir: " .. dir)
	--         -- print("My.IsDir(dir): " .. tostring(My.IsDir(dir)))
	--         -- ISSUE: Doesn't work
	--         -- if not My.IsDir(dir) then
	--         --     error("Invalid dir: " .. dir)
	--         -- end
	--     end,
	-- })
	M.ExecTermCmd("pwd | xclip -selection clipboard")
end

function M.ExecCmd(cmd)
	vim.cmd('TermExec cmd="' .. cmd .. '"')
end

function M.ExecBuf()
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	M.ExecCmd(file)
end

return M
