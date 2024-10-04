local M = {}

function M.MakeFileUnderCursorExecutable()
    local filepath = My.oil.functions.GetFullPathUnderCursor()
    My.sys.MakeFileExecutable(filepath)
end

function M.ExecuteFileUnderCursor()
    local filepath = My.oil.functions.GetFullPathUnderCursor()
    My.oil.functions.ExecuteCmd(filepath, { ask_input = true })
end

return M
