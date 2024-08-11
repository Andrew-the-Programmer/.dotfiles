function GetBuf()
    return vim.api.nvim_get_current_buf()
end

function PrintBuf()
    Print(GetBuf())
end

function GetBufOpts()
    return vim.bo
end

function GetBufOpt(opt)
    return vim.api.nvim_buf_get_option(GetBuf(), opt)
end

function GetBufName()
    return vim.api.nvim_buf_get_name(GetBuf())
end

function SetBufName(name)
    vim.api.nvim_buf_set_name(GetBuf(), name)
end

function PrintBufOpts()
    Print(GetBufOpts())
end

function GetBufList()
    return vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf)
    end, vim.api.nvim_list_bufs())
end

function PrintBufList()
    Print(GetBufList())
end

function My.ToggleTerm(cmd, prefix, tcmd)
    prefix = prefix or "botright vs"
    tcmd = tcmd or "term://"
    cmd = cmd or "zsh"
    local args = { prefix, tcmd, cmd }
    local execcmd = table.concat(args, " ")
    vim.cmd(execcmd)
end

function My.ToggleTerm2(table)
    --[[
    table = {
        cmd="zsh",
        prefix="botright vs",
        tcmd="term://"
    }
    --]]

    setmetatable(table, { __index = { cmd = "zsh", prefix = "botright vs", tcmd = "term://" } })
    prefix = prefix or "botright vs"
    tcmd = tcmd or "term://"
    cmd = cmd or "zsh"
    local args = { prefix, tcmd, cmd }
    local execcmd = table.concat(args, " ")
    vim.cmd(execcmd)
end
