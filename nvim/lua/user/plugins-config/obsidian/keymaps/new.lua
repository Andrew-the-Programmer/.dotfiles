local obsidian = require("obsidian")
local util = require("obsidian.util")
local mof = require("user.plugins-config.obsidian.functions")
local search = require("obsidian.search")
local img_paste = require("user.plugins-config.obsidian.paste_image")
local Note = require("obsidian.note")

local mappings = {
	["<leader>of"] = {
		action = function()
			local client = obsidian.get_client()
			local function action(note, selected)
				client:open_note(note)
			end
			mof.FindNote(action)
		end,
		opts = { desc = "Insert link" },
	},
	["<leader>oli"] = {
		action = function()
			local function action(note, selected)
				local link = util.wiki_link_path_prefix({ path = note.id, label = note.title })
				My.nvim.InsertText(link)
			end
			mof.FindNote(action)
		end,
		opts = { desc = "Insert link" },
	},
	["<leader>ole"] = {
		action = function()
			if not util.cursor_on_markdown_link(nil, nil, true, true) then
				print("Cursor is not on a link")
				return
			end
			local open, close, _ = util.cursor_on_markdown_link()
			if open == nil or close == nil then
				return
			end
			local line = My.nvim.GetLine()
			local _, label, link_type = util.parse_cursor_link()
			local row, _ = My.nvim.GetCursorPos()
			if link_type == search.RefTypes.WikiWithAlias then
				if label == nil then
					return
				end
				local a, b = line:find(("|%s]]"):format(label), open)
				a = a + 1
				b = b - 2
				My.nvim.ViewInside({ row, a }, { row, b })
			elseif link_type == search.RefTypes.Wiki then
				My.nvim.InsertText("|", { pos = { row = row, col = close - 2 } })
				My.nvim.SetCursor({ row, close })
				vim.cmd("startinsert")
			else
				print("Unknown link type")
			end
		end,
		opts = { desc = "Edit link label" },
	},
	["<leader>on"] = {
		action = function()
			local date = os.date("%d-%m-%y")
			vim.ui.input({
				prompt = "title: ",
				default = date,
			}, function(input)
				if input == nil then
					return
				end
				vim.cmd("ObsidianNew " .. input)
			end)
		end,
		opts = { desc = "Create new obsidian note" },
	},
	["<leader>or"] = {
		action = function()
			local client = obsidian.get_client()
			local note = client:current_note()
			if note == nil then
				return
			end
			local note_title = note.title
			vim.ui.input({
				prompt = "new title: ",
				default = note_title,
			}, function(title)
				if title == nil then
					return
				end
				local id = client:new_note_id(title)
				vim.cmd("ObsidianRename" .. id)
				note = client:current_note()
				if note == nil then
					return
				end
				note:add_alias(title)
				note.id = id
				note:save()
				vim.cmd("edit!")
			end)
		end,
		opts = { desc = "Rename obsidian note" },
	},
	["<leader>oip"] = {
		action = function()
			img_paste.PasteImage()
		end,
		opts = { buffer = true, desc = "Paste img to Obsidian" },
	},
	["<leader>oin"] = {
		action = function()
			local fig_name = mof.GetImgName("svg")
			local img_folder = mof.GetImgFolder()
			local fig_path = img_folder:joinpath(fig_name).filename
			local final_cmd = mof.GetImgCmd_new(fig_path)
			My.nvim.SilentExecCmdInBackground(final_cmd)
			mof.PasteImgLink(fig_name)
		end,
		opts = { buffer = true, desc = "Create new img" },
	},
	["<leader>oie"] = {
		action = function()
			local fig_path = mof.GetImgLinkPath()
			if fig_path == nil then
				print("Cursor is not on a markdown link")
				return
			end
			mof.ImageEdit(fig_path)
		end,
		opts = { buffer = true, desc = "Edit Obsidian image" },
	},
	["<leader>oe"] = {
		action = function()
			local line = My.nvim.GetLine()
			local m = line:match("^(%d+). %[%[.*%]%]")
			if m == nil then
				return
			end
			local num = tonumber(m)
			if not util.cursor_on_markdown_link() then
				return
			end
			local path, link_label, _ = util.parse_cursor_link()
			local client = obsidian.get_client()
			local notes_path = client.dir / client.opts.notes_subdir
			local note_path = client:new_note_path({ id = path, dir = notes_path })
			local note = mof.GetNote(note_path)
			local title = note.title
			if title == nil then
				return
			end
			local function sub(t, p, r)
				p = tostring(p)
				local ps = {
					{ " ", " " },
					{ " ", "$" },
					{ "^", " " },
					{ "^", "$" },
				}
				for _, v in ipairs(ps) do
					local p1, p2 = unpack(v)
					local p3 = My.lua.If(p1 ~= "^", p1, "")
					local p4 = My.lua.If(p2 ~= "$", p2, "")
					t = t:gsub(p1 .. p .. p2, p3 .. r .. p4)
				end
				return t
			end
			local new_title = title
			new_title = sub(new_title, "%d%d%-%d%d%-%d%d", os.date("%d-%m-%y"))
			new_title = sub(new_title, num, num + 1)
			local new_link_label = link_label
			new_link_label = sub(new_link_label, "%d%d%-%d%d%-%d%d", os.date("%d-%m-%y"))
			new_link_label = sub(new_link_label, num, num + 1)
			local new_note = client:new_note(new_title)
			local new_link = util.wiki_link_id_prefix({ id = new_note.id, label = new_link_label })
			My.nvim.InsertLine(("%s. %s"):format(tostring(num + 1), new_link))
			client:open_note(new_note)
		end,
		opts = { buffer = true, desc = "Obsidian extend" },
	},
}

return mappings
