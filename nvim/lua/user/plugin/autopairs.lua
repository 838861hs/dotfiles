-- ~/.config/nvim/lua/user/autopairs.lua

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- Insertモードに入った時に読み込む
	config = function()
		require("nvim-autopairs").setup({
			-- 設定オプション
			disable_filetype = { "TelescopePrompt", "vim" }, -- 特定のファイルタイプでは無効化
			map_cr = false, -- Enterでの自動改行ペアを無効化（coc.nvimやemmetと競合するため）
		})
	end,
}
