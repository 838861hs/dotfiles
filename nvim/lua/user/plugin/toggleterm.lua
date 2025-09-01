-- lua/user/plugin/toggleterm.lua
-- toggleterm.nvim の設定
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "horizontal", -- デフォルトは下にペインを出す
			size = 15,
		})

		-- <leader>t でターミナルをトグル
		vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
	end,
}
