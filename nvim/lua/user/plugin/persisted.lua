-- lua/user/plugin/persisted.lua
return {
	"olimorris/persisted.nvim",
	config = function()
		require("persisted").setup({
			use_git_branch = true, -- ブランチごとにセッション保存
		})

		-- コマンドショートカット
		vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true }) -- 保存
		vim.keymap.set("n", "<leader>sl", ":SessionLoad<CR>", { noremap = true, silent = true }) -- 復元
		vim.keymap.set("n", "<leader>sp", ":Telescope persisted<CR>", { noremap = true, silent = true }) -- 一覧
		vim.keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { noremap = true, silent = true }) -- 削除
	end,
}
