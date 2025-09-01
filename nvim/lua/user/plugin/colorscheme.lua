-- lua/user/plugin/colorscheme.lua

-- Kanagawa テーマを読み込む設定
return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000, -- colorschemeは最優先で読み込む
	config = function()
		vim.cmd("colorscheme kanagawa")
	end,
}
