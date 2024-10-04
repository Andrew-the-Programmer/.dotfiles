local M = {}

function GetCurBuf()
	return vim.api.nvim_get_current_buf()
end

function GetBufOpts(buf)
	buf = buf or GetCurBuf()
	return vim.bo[buf]
end

function GetBufOpt(opt, buf)
	buf = buf or GetCurBuf()
	return vim.api.nvim_buf_get_option(buf, opt)
end

function GetBufName(buf)
	buf = buf or GetCurBuf()
	return vim.api.nvim_buf_get_name(buf)
end

function SetBufName(name)
	vim.api.nvim_buf_set_name(GetBuf(), name)
end

function GetBufList()
	return vim.tbl_filter(function(buf)
		return vim.api.nvim_buf_is_loaded(buf)
	end, vim.api.nvim_list_bufs())
end

function M.Notify(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

function M.Execute(list_of_functions)
	list_of_functions = list_of_functions or {}

	if #list_of_functions == 0 then
		return
	end

	local first_func = table.remove(list_of_functions, 1)

	vim.defer_fn(function()
		first_func()
		M.Execute(list_of_functions)
	end, 0)
end

function M.GetBufFile(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	return file
end

function M.MakeBufExecutable(buf)
	local file = M.GetBufFile(buf)
	local cmd = "!chmod +x " .. My.lua.Surround(file, '"')
	vim.cmd(cmd)
end

return M
