-- ~/.config/nvim/lua/user/plugin/emmet.lua
-- emmet-vim の設定（展開キーを <C-y>, に変更）

return {
	"mattn/emmet-vim",
	lazy = false,
	config = function()
		-- Emmet展開は <C-y>, に割り当て（VS Code の Tab 展開に近い操作）
		vim.g.user_emmet_leader_key = "<C-y>"
		vim.g.user_emmet_expandabbr_key = "<C-y>,"
	end,
}
