-- $HOME/.config/nvim/lua/overseer/template/user/cpp_build.lua

local dir = vim.fn.expand("%:p:h")
local parentdir = vim.fn.expand("%:p:h:h")
local file = vim.fn.expand("%:p")

return {
    name = "g++ build",
    builder = function()
        -- Full path to current file (see :help expand())
        local outdirname = "out"
        local outdir = parentdir .. "/" .. outdirname
        local filename = vim.fn.expand(file .. ":r")

        return {
            cmd = { "g++" },
            args = { file, "-o", outdir },
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    cwd = dir,
    condition = {
        filetype = { "cpp" },
    },
}
