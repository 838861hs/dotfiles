-- lua/user/plugin/auto-save.lua
return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			enabled = true, -- 自動保存を有効化
			trigger_events = { "InsertLeave" }, -- Insertモード終了時に保存
			execution_message = { enabled = false }, -- 保存メッセージを非表示にする
		})
	end,
}
