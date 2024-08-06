opts = {
    default_file_explorer = true,
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = false,
    use_default_keymaps = false,
}

return opts
