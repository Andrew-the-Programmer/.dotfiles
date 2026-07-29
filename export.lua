local path = require("path")
local env = require("path.env")

local M = {}

function M.abs(file)
	file = env.expand(file)
	file = path.abs(file)
	return file
end

function M.link(target, link)
	os.execute(string.format("mkdir -p '%s'", path.parent(link)))
	os.execute(string.format("ln -sin '%s' '%s'", target, link))
end

function M.export(pkg)
	local mod = require(pkg .. ".export")

	local links = nil

	if type(mod.links) == "function" then
		links = mod.links()
	elseif type(mod.links) == "table" then
		links = mod.links
	end

	for _, pair in ipairs(links) do
		local target = pair[1]
		local link = pair[2]

		if not path.exists(target) then
			target = path(path.cwd(), pkg, target)
		end

		target = M.abs(target)
		link = M.abs(link)

		print(string.format("%s -> %s", target, link))
		M.link(target, link)
	end
end

local packages = {}

for i = 1, #arg do
	table.insert(packages, arg[i])
end

for _, pkg in ipairs(packages) do
	print("Exporting", pkg)
	M.export(pkg)
end
