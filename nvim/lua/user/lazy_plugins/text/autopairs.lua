-- https://github.com/windwp/nvim-autopairs
-- complete double ", (, [, { etc...
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		-- enabled = function(bufnr)
		-- 	local synstack = My.nvim.get_synstack()
		-- 	if My.lua.ListsIntersect(synstack, {
		-- 		"texMathZoneTI",
		-- 		"texMathZoneTD",
		-- 		"mkdMath",
		-- 	}) then
		-- 		return false
		-- 	end
		-- 	return true
		-- end,
	},
}
