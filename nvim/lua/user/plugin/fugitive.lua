-- lua/user/plugin/fugitive.lua
return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gstatus", "Gcommit", "Gpush" },

	config = function()
		-- Git 差分表示のショートカット
		vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { noremap = true, silent = true }) -- 縦分割
		vim.keymap.set("n", "<leader>gvd", ":Gvdiffsplit<CR>", { noremap = true, silent = true }) -- 横分割
	end,
}
