-- nvim-ufo 設定ファイル

return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },

	config = function()
		-- 基本設定
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})

		-- キーマップ
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "すべて展開" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "すべて閉じる" })

		-- ======================
		-- fold 状態の保存と復元
		-- ======================

		-- バッファを閉じるときに状態を保存
		vim.api.nvim_create_autocmd("BufWinLeave", {
			pattern = "*",
			command = "silent! mkview",
		})

		-- バッファを開いたとき:
		-- ① まずすべて展開 (zR)
		-- ② そのあと保存されていれば復元
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				vim.cmd("silent! normal! zR") -- 全展開
				vim.cmd("silent! loadview") -- 保存状態を復元（あれば上書きされる）
			end,
		})
	end,
}
