local M = {}

M.links = function()
	local path = require("path")
	local zsh_config_dir = "~/.config/zsh"

	local links = {
		{
			"zshenv",
			"~/.zshenv",
		},
		{
			"zshrc",
			path(zsh_config_dir, ".zshrc"),
		},
	}

	local simple_refs = {
		"source",
		"plugins-config",
		"p10k-configs",
		"plugin-functions.sh",
		"zshrc.sh",
	}

	for _, f in ipairs(simple_refs) do
		table.insert(links, {
			f,
			path(zsh_config_dir, f),
		})
	end
	return links
end

return M
