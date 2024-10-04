local oil = require("oil")

function My.Oil.OpenTerm(t)
	t = t or {}
	t.prefix = t.prefix or "edit"
	local dir = oil.get_current_dir()
	t.cmds = t.cmds or {}
	table.insert(t.cmds, "cd " .. dir)
	My.OpenTerm(t)
end

function My.Oil.CloseTerm()
	My.CloseTerm()
end

function My.Oil.CdToTermCwd()
	local dir
	My.Execute({
		function()
			My.GetTermCwd()
		end,
		function()
			dir = vim.fn.getreg("+")
		end,
		function()
			My.Print("dir: " .. dir)
		end,
		function()
			oil.open(dir)
		end,
	})
end
