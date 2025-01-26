return {
    -- https://github.com/epwalsh/obsidian.nvim
    "epwalsh/obsidian.nvim",
    version = "*", -- latest
    -- lazy = true,
    -- ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "preservim/vim-markdown",
    },
    config = function()
        vim.g.vim_markdown_math = 1
        vim.opt.conceallevel = 2

        local obsidian = require("obsidian")

        local function GetImgName(ext)
            local fig_name = vim.api.nvim_get_current_line()
            local time = tostring(os.time())
            if fig_name ~= "" then
                fig_name = time .. "-" .. fig_name
            else
                fig_name = time
            end
            fig_name = fig_name .. "." .. ext
            return fig_name
        end
        local function PasteImgLink(fig_name)
            My.nvim.SetLine("![[" .. fig_name .. "]]")
        end
        local function GetImgFolder()
            local path = require("obsidian.path")
            local client = obsidian.get_client()
            local img_folder = path.new(client.opts.attachments.img_folder)
            return img_folder
        end
        local function GetImgCmd(fig_path)
            local cmd = "~/my/scripts/inkscape-figures/main.py"
            cmd = vim.fn.expand(cmd)
            local args = "-path"
            local final_cmd = cmd .. " " .. args .. " " .. My.lua.Surround(fig_path, '"')
            return final_cmd
        end
        local function GetImgCmd_edit(fig_path)
            local img_cmd = GetImgCmd(fig_path)
            local args = "-edit"
            local final_cmd = img_cmd .. " " .. args
            return final_cmd
        end
        local function GetImgCmd_new(fig_path)
            local img_cmd = GetImgCmd(fig_path)
            local args = "-create -edit"
            local final_cmd = img_cmd .. " " .. args
            return final_cmd
        end
        local mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return obsidian.util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return obsidian.util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return obsidian.util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },
            ["<leader>oo"] = {
                action = function()
                    return "<cmd>ObsidianOpen<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Open Obsidian" },
            },
            ["<leader>on"] = {
                action = function()
                    return "<cmd>ObsidianNew<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Create new obsidian note" },
            },
            ["<leader>or"] = {
                action = function()
                    return "<cmd>ObsidianRename<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Rename obsidian note" },
            },
            ["<leader>os"] = {
                action = function()
                    return "<cmd>ObsidianSearch<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Search for obsidian note" },
            },
            ["<leader>ot"] = {
                action = function()
                    return "<cmd>ObsidianTemplate<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Insert Obsidian template" },
            },
            ["<leader>ol"] = {
                action = function()
                    return "<cmd>ObsidianLink .<CR>"
                end,
                opts = { buffer = true, expr = true, desc = "Insert Obsidian template" },
            },
            ["<leader>oip"] = {
                action = function()
                    local fig_name = GetImgName("png")
                    vim.cmd("ObsidianPasteImg " .. fig_name)
                    PasteImgLink(fig_name)
                end,
                opts = { buffer = true, desc = "Paste img to Obsidian" },
            },
            ["<leader>oin"] = {
                action = function()
                    local fig_name = GetImgName("svg")
                    local img_folder = GetImgFolder()
                    local fig_path = img_folder:joinpath(fig_name).filename
                    local final_cmd = GetImgCmd_new(fig_path)
                    My.nvim.SilentExecCmdInBackground(final_cmd)
                    PasteImgLink(fig_name)
                end,
                opts = { buffer = true, desc = "Create new img" },
            },
            ["<leader>oit"] = {
                action = function()
                    local fig_name = GetImgName("svg")
                    PasteImgLink(fig_name)
                end,
                opts = { buffer = true, desc = "Create new img" },
            },
            ["<leader>oie"] = {
                action = function()
                    if not obsidian.util.cursor_on_markdown_link(nil, nil, true, true) then
                        print("Cursor is not on a markdown link")
                        return
                    end
                    local _, fig_name, _ = obsidian.util.parse_cursor_link()
                    local img_folder = GetImgFolder()
                    local fig_path = img_folder:joinpath(fig_name).filename
                    local final_cmd = GetImgCmd_edit(fig_path)
                    My.nvim.SilentExecCmdInBackground(final_cmd)
                end,
                opts = { buffer = true, desc = "Edit Obsidian image" },
            },
            ["<localleader>mn"] = {
                action = function()
                    local n = vim.fn.input("Number of lines: ")
                    local row, _ = My.nvim.GetCursorPos()
                    for i = 0, n - 1 do
                        local cur_row = row + i
                        My.nvim.PrependText(i + 1 .. ". ", { line_number = cur_row })
                    end
                end,
                opts = { buffer = true, desc = "Edit Obsidian image" },
            },
        }
        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        local function note_id_func(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title
                suffix = suffix:gsub(" ", "-")
                -- suffix = suffix:gsub("[^A-Za-z0-9-]", "")
                suffix = suffix:lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end
        local opts = {
            workspaces = {
                {
                    name = "Second Brain",
                    path = "~/MEGA/SecondBrain",
                },
            },
            notes_subdir = "Zettelkasten",
            completion = {
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
            },
            mappings = mappings,
            new_notes_location = "NewNotes",
            note_id_func = note_id_func,
        }
        obsidian.setup(opts)
    end,
}
