local M = {}
local util = require("obsidian.util")
local run_job = require("obsidian.async").run_job
local obsidian = require("obsidian")
local Path = require("obsidian.path")
local oip = require("user.plugins-config.obsidian.obsidian_img_paste")

function M.PasteImgLink(fig_name)
	My.nvim.SetLine("![[" .. fig_name .. "]]")
end

function M.UniqueFigName(fig_name)
	if fig_name == nil then
		local id = tostring(math.random(100, 999))
		return id
	end
	return fig_name .. "-" .. M.UniqueFigName()
end

function M.PasteImage(fig_name, flag)
	local client = obsidian.get_client()
	local img_folder = Path.new(client.opts.attachments.img_folder)
	if not img_folder:is_absolute() then
		img_folder = client.dir / client.opts.attachments.img_folder
	end
	---@type string|?
	local default_name
	if client.opts.image_name_func then
		default_name = client.opts.image_name_func()
	end

    local paste_opts = {
        fname = data.args,
        default_dir = img_folder,
        default_name = default_name,
        should_confirm = client.opts.attachments.confirm_img_paste,
    }

	if M.clipboard_is_img() then
        local path = oip.paste_img(paste_opts)
		if path ~= nil then
			util.insert_text(client.opts.attachments.img_text_func(client, path))
		end
		return
	end

	flag = My.lua.IfNil(flag, true)
	if not flag then
		return
	end

	local this_os = util.get_os()
	if this_os == util.OSType.Linux or this_os == util.OSType.FreeBSD then
		local clipboard = vim.fn.getreg("+")
		local path_list = My.lua.Split(clipboard, "\n")
		for _, path in pairs(path_list) do
			local cmd = ('xclip -selection clipboard -target image/png -i < "%s"'):format(path)
			fig_name = My.sys.FileBaseName(path)
			local suc = os.execute(cmd)
			if type(suc) == "number" and suc ~= 0 then
				error("could not copy path to img")
			end
			M.PasteImage(fig_name, false)
			My.nvim.InsertLine("")
			My.nvim.GoDown()
		end
	else
		error("image saving not implemented for OS '" .. this_os .. "'")
	end
end

return M
