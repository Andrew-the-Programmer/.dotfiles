local oil = require("oil")

function MyOil.OpenTerm(t)
    t = t or {}
    t.prefix = t.prefix or "edit"
    local dir = oil.get_current_dir()
    t.cmds = t.cmds or {}
    table.insert(t.cmds, "cd " .. dir .. " && clear")
    My.OpenTerm(t)
end

function MyOil.CloseTerm()
    My.CloseTerm()
end

function MyOil.CdToTermCwd()
    if vim.bo.buftype ~= "terminal" then
        Notify("Not in terminal, can't cd")
        return
    end

    -- get term cwd
    local dir = My.GetTermCwd()
    Notify(dir)

    -- go to oil buffer
    -- vim.cmd("wincmd k")
    
    vim.cmd.edit("new")

    -- vim.cmd("Oil")

    -- oil.open(dir)
end
