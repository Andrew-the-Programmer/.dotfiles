local M = {}

local map = vim.keymap.set

function M.GetText(text)
    if text then
        return text
    end
    text = My.nvim.get_visual_selection_text()
    if text then
        return text[1]
    end
    return vim.api.nvim_get_current_line()
end

function M.PinyinCmd(text)
    return My.lua.GetCmd({ cmd = "pinyin-tool", input = text })
end

function M.GetPinyin(text)
    local cmd = M.PinyinCmd(text)
    return My.lua.GetCmdOutput(cmd)
end

function M.PutPinyin(text, opts)
    local pinyin = M.GetPinyin(text, opts)
    My.nvim.PutText(pinyin, opts)
end

---@param text string | nil
---@param opts table | nil
---@param opts.lang string | nil arg to trans cmd
---@param opts.from string | nil language to translate from
---@param opts.to string | nil language to translate to
function M.TranslationCmd(text, opts)
    opts = opts or {}
    local from = opts.from or ""
    local to = opts.to or "eng"
    local lang = opts.lang or (from .. ":" .. to)
    local cmd = My.lua.GetCmd({
        cmd = "trans",
        args = { "-b", lang },
        text = text,
    })
    return cmd
end

function M.GetTranslation(text, opts)
    local cmd = M.TranslationCmd(text, opts)
    return My.lua.GetCmdOutput(cmd)
end

---@param text string | nil
---@param opts table | nil
---@param opts.translation string | nil translation if already found
function M.PutTranslation(text, opts)
    opts = opts or {}
    local translation = opts.translation or M.GetTranslation(text, opts)
    My.nvim.PutText(translation, opts)
end

---@deprecated
function M.TextOperation(funcs, opts)
    local text = M.GetText()
    for _, func in ipairs(funcs) do
        func(text, opts)
    end
    My.nvim.EnterNormalMode()
end

function M.TranslateToChinese(opts)
    local text = M.GetText()
    local lopts = {
        to = "zh-CH",
    }
    opts = opts or {}
    setmetatable(opts, { __index = lopts })
    local translation_ch = M.GetTranslation(text, opts)
    opts.translation = translation_ch
    M.PutTranslation(nil, opts)
    M.PutPinyin(translation_ch, opts)
    My.nvim.EnterNormalMode()
end

function M.Translate(opts)
    local lopts = {}
    opts = opts or {}
    setmetatable(opts, { __index = lopts })
    local text = M.GetText()
    M.PutTranslation(text, opts)
    My.nvim.EnterNormalMode()
end

function M.TranslateToEnglish_A()
    M.Translate({ to = "eng", how = "a", sep = " - " })
end

function M.TranslateToEnglish_NL()
    M.Translate({ to = "eng", how = "nl" })
end

function M.TranslateToChinese_A()
    M.TranslateToChinese({ how = "a", sep = " - " })
end

function M.TranslateToChinese_NL()
    M.TranslateToChinese({ how = "a", sep = " - " })
end

map({ "n", "v" }, "<localleader>cp", function()
    local text = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
    }
    M.PutPinyin(text, opts)
    My.nvim.EnterNormalMode()
end)
map({ "n", "v" }, "<localleader>cP", function()
    local text = M.GetText()
    local opts = {
        how = "nl",
    }
    M.PutPinyin(text, opts)
    My.nvim.EnterNormalMode()
end)

map({ "n", "v" }, "<localleader>ct", function()
    local text_ch = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
    }
    M.PutPinyin(text_ch, opts)
    M.PutTranslation(text_ch, opts)
    My.nvim.EnterNormalMode()
end)
map({ "n", "v" }, "<localleader>cT", function()
    local text_ch = M.GetText()
    local opts = {
        how = "nl",
    }
    M.PutPinyin(text_ch, opts)
    M.PutTranslation(text_ch, opts)
    My.nvim.EnterNormalMode()
end)

map({ "v" }, "<localleader>cy", function()
    local text_ch = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
    }
    My.nvim.InsertLine(text_ch)
    M.PutPinyin(text_ch, opts)
    M.PutTranslation(text_ch, opts)
    My.nvim.EnterNormalMode()
end)

map({ "n", "v" }, "<localleader>tt", function()
    local text = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
    }
    M.PutTranslation(text, opts)
    My.nvim.EnterNormalMode()
end)
map({ "n", "v" }, "<localleader>tT", function()
    local text = M.GetText()
    local opts = {
        how = "nl",
    }
    M.PutTranslation(text, opts)
    My.nvim.EnterNormalMode()
end)

map({ "n", "v" }, "<localleader>te", function()
    local text = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
        to = "eng",
    }
    M.PutTranslation(text, opts)
    My.nvim.EnterNormalMode()
end)
map({ "n", "v" }, "<localleader>tE", function()
    local text = M.GetText()
    local opts = {
        how = "nl",
        to = "eng",
    }
    M.PutTranslation(text, opts)
    My.nvim.EnterNormalMode()
end)

map({ "n", "v" }, "<localleader>tc", function()
    local text = M.GetText()
    local opts = {
        how = "a",
        sep = " - ",
        to = "zh-CH",
    }
    local translation_ch = M.GetTranslation(text, opts)
    opts.translation = translation_ch
    M.PutTranslation(nil, opts)
    -- M.PutPinyin(translation_ch, opts)
    My.nvim.EnterNormalMode()
end)

map({ "n", "v" }, "<localleader>tC", function()
    local text = M.GetText()
    local opts = {
        how = "nl",
        to = "zh-CH",
    }
    local translation_ch = M.GetTranslation(text, opts)
    opts.translation = translation_ch
    M.PutTranslation(nil, opts)
    -- M.PutPinyin(translation_ch, opts)
    My.nvim.EnterNormalMode()
end)

return M
