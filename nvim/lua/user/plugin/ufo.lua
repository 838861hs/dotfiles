-- nvim-ufo 設定ファイル

return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },

	config = function()
		vim.o.foldenable = false
		-- 基本設定
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})

		-- キーマップ
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "すべて展開" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "すべて閉じる" })
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				vim.cmd("silent! normal! zR") -- 全展開
			end,
		})
	end,
}
