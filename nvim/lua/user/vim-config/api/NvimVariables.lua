function GetBuf()
    return vim.api.nvim_get_current_buf()
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

function GetBufList()
    return vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf)
    end, vim.api.nvim_list_bufs())
end
