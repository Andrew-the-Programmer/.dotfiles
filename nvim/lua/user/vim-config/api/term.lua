function My.InputCR()
    vim.cmd.startinsert()
    vim.api.nvim_feedkeys("\r", "t", false)
end

function My.ExecTermCmd(cmd)
    vim.cmd.startinsert()
    vim.api.nvim_feedkeys(cmd, "t", false)
    My.InputCR()
end

function My.ExecTermCmds(cmds)
    for _, cmd in pairs(cmds) do
        My.ExecTermCmd(cmd)
    end
end

function My.OpenTerm(t)
    --[[
    t = {
        pos="f",
        shell="zsh",
        cmds={},
        prefix="botright vs",
        tcmd="term://"
    }
    --]]

    t = t or {}
    setmetatable(t, { __index = { pos = "b", shell = "zsh", cmds = {}, prefix = "15sp", tcmd = "term://" } })

    local args = { t.prefix, t.tcmd, t.shell }
    local execcmd = table.concat(args, " ")
    vim.cmd(execcmd)

    vim.cmd.startinsert()

    My.ExecTermCmds(t.cmds)

    vim.cmd.startinsert()
end

function My.CloseTerm()
    if vim.bo.buftype == "terminal" then
        vim.cmd("bd!")
        -- vim.cmd("q")
    else
        Notify("Not a terminal buffer")
    end
end

function My.GetTermCwd()
    if vim.bo.buftype ~= "terminal" then
        Notify("Not a terminal buffer")
        return
    end
    My.ExecTermCmd("pwd | xclip -selection clipboard")
    local dir = vim.fn.getreg("+")
    return dir
end
