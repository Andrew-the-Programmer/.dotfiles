-- $HOME/.config/nvim/lua/overseer/template/user/cpp_build.lua

local overseer = require("overseer")

function Dir()
    local dir = vim.fn.expand("%:p:h")
    return dir
end

function File()
    local file = vim.fn.expand("%:p")
    return file
end

local function FileBaseName()
    return vim.fn.fnamemodify(File(), ":t:r")
end

local execute_cmd = My.toggleterm.execute.execute_cmd

local function Execute(cmd)
    local opts = {
        ask_input = false,
        go_back = false,
        error = false,
    }
    execute_cmd(cmd, opts)
end

overseer.register_template({
    name = "g++ - normal",
    builder = function()
        local outdirname = "out"
        local outdir = Dir() .. "/" .. outdirname
        local filebasename = FileBaseName()
        local execfile = outdir .. "/" .. filebasename
        local file = File()

        local args = {
            "g++",
            "-std=c++20",
            "-I/usr/local/include",
            "-L/usr/local/lib",
            "-lboost_system",
            "-lboost_coroutine",
            "-lboost_context",
            "-o " .. execfile,
            file,
        }
        local cmd = ""

        for _, v in pairs(args) do
            cmd = cmd .. " " .. v
        end

        Execute("mkdir -p " .. outdir)
        Execute(cmd)
        Execute(execfile)

        return {
            name = "Done",
            cmd = { "echo" },
            args = { "Done" },
        }
    end,
    condition = {
        filetype = { "cpp" },
        dir = vim.fn.getcwd(),
    },
})

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
