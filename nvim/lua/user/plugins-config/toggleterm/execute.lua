local Terminal = require("toggleterm.terminal").Terminal
local mtt = My.toggleterm
local mttf = mtt.functions

local M = {}

M.TermExecute = Terminal:new({
    -- Need this
    -- See My.toggleterm.term.Term
    newline_chr = "\r",

    direction = "float",
    -- hidden = true,
    float_opts = {
        border = "double",
    },

    display_name = "TermExecute",
    id = mttf.GetUniqueTermId(),
    count = mttf.GetUniqueTermId(),
    on_open = function(term)
        mttf.Focuse(term)
        mttf.Clear(term)
    end,
})
-- function M.TermExecute:new(opts)
-- 	local s = M.TermExecute
-- 	opts = opts or {}
-- 	setmetatable(opts, { __index = s })
-- 	return opts
-- end

-- mttf.LoadTerm(M.TermExecute)

---See Send
---@param cmd string
---@param opts table|nil See Send.
function M.execute_cmd(cmd, opts)
    mttf.OpenTerm(M.TermExecute)
    mttf.Send(M.TermExecute, cmd, opts)
end

---@param buf integer buffer to execute
---@param opts table|nil See execute_cmd.
function M.execute_buf(buf, opts)
    opts = opts or {}
    opts.go_back = opts.go_back or false
    opts.ask_input = opts.ask_input or true
    buf = buf or vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    M.execute_cmd(file, opts)
end

vim.keymap.set(
    { "n" },
    "<leader>te",
    M.execute_buf,
    { desc = "Execute current buffer's file", noremap = true, silent = true }
)

return M
