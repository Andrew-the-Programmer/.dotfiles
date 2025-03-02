local M = {}
local img_paste = require("user.plugins-config.obsidian.paste_image")
local oil = require("oil")
local mo = My.oil

function M.PasteImage()
	local cwd = oil.get_current_dir()
	vim.ui.input({
		prompt = "filename: ",
	}, function(fn)
		local file = cwd .. "/" .. fn .. ".png"
		if not img_paste.clipboard_is_img() then
			return
		end
		img_paste.save_clipboard_image(file)
	end)
end

function M.CopyImage()
	local img = mo.functions.GetFullPathUnderCursor()
	vim.cmd(('!cat "%s" | xclip -selection clipboard -target image/png -i'):format(img))
end

return M
