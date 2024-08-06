local oil = require("oil")
local actions = oil.actions

local keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = { "actions.select", opts = { close = false }, desc = "Open" },
    ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-S>"] = {
        "actions.select",
        opts = { horizontal = true },
        desc = "Open the entry in a horizontal split",
    },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    ["<C-c>"] = "actions.close",
    ["<C-R>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },

    ["<localleader>ox"] = {
        "actions.open_external",
        desc = "Open the file in an external program",
    },

    ["<localleader>th"] = {
        "actions.toggle_hidden",
        desc = "Toggle hidden files",
    },
    ["<localleader>tr"] = {
        "actions.toggle_trash",
        desc = "Toggle trash",
    },
    ["<localleader>tp"] = {
        "actions.preview",
        desc = "Toggle preview",
    },

    ["<localleader>gp"] = {
        "actions.parent",
        desc = "Go to parent directory",
    },

    ["<localleader>ss"] = {
        "actions.change_sort",
        desc = "Change sort order",
    },
    ["<localleader>sn"] = {
        "actions.change_sort",
        opts = {
            sort = {
                { "type", "asc" },
                { "name", "asc" },
            },
        },
        desc = "Sort by type->name",
    },
    ["<localleader>sl"] = {
        "actions.change_sort",
        opts = {
            sort = {
                { "type",  "asc" },
                { "mtime", "asc" },
                { "name",  "asc" },
            },
        },
        desc = "Sort by type->mtime->name",
    },

    ["<localleader>tt"] = {
        function()
            vim.cmd("botright 15split term")
        end,
        desc = "Toggle terminal",
    },

    ["<localleader>id"] = {
        -- "oil.set_columns",
        -- opts = { cols = { "icon", "permissions", "size", "mtime" } },
        function()
            oil.set_columns({ "icon", "permissions", "size", "mtime" })
        end,
        desc = "Set columns to detailed",
    },
    ["<localleader>ic"] = {
        function()
            oil.set_columns({ "icon" })
        end,
        desc = "Set columns to compact",
    },

    -- You can pass additional opts to vim.keymap.set by using
    -- a table with the mapping as the first element.
    ["<leader>ff"] = {
        function()
            require("telescope.builtin").find_files({
                cwd = oil.get_current_dir(),
            })
        end,
        mode = "n",
        nowait = true,
        desc = "Find files in the current directory",
    },
    -- Mappings that are a string starting with "actions." will be
    -- one of the built-in actions, documented below.
    -- ["`"] = "actions.tcd",
    -- Some actions have parameters. These are passed in via the `opts` key.
    ["<localleader>:"] = {
        "actions.open_cmdline",
        opts = {
            shorten_path = true,
            modify = ":h",
        },
        desc = "Open the command line with the current directory as an argument",
    },
}

return keymaps
