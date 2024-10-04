local M = {}

--- Check if a file or directory exists in this path
function M.FileExists(file)
    local ok, err, code = os.rename(file, file)
    return ok or code == 13
    -- if not ok then
    --     if code == 13 then
    --         -- Permission denied, but it exists
    --         return true
    --     end
    -- end
    -- return true
end

--- Check if a directory exists in this path
function M.IsDir(path)
    print("path: " .. path)
    -- "/" works on both Unix and Windows
    return M.FileExists(path)
end

function M.MakeFileExecutable(file)
    vim.cmd("silent execute '!chmod +x \"" .. file .. "\"'")
end

function M.ReadFile(path)
    local file = io.open(path, "rb")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

return M
