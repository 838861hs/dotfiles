-- lua/user/plugin/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- アイコン表示用
	config = function()
		require("nvim-tree").setup({})

		-- キーマップ（ノーマルモード）
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
	end,
}
