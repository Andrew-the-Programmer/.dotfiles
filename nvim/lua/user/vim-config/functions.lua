function Dump(o)
    -- Convert lua values to human readable string
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function Print(value)
    print(Dump(value))
end

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
