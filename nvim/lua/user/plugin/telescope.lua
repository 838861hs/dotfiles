-- lua/user/plugin/telescope.lua
-- telescope.nvim の設定
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup()

		-- persisted.nvim の拡張をロード（エラーになっても無視）
		pcall(telescope.load_extension, "persisted")

		-- ===== ファイル検索系 =====
		vim.api.nvim_create_user_command("FF", function()
			builtin.find_files()
		end, {})
		vim.api.nvim_create_user_command("FG", function()
			builtin.git_files()
		end, {})
		vim.api.nvim_create_user_command("FS", function()
			builtin.live_grep()
		end, {})
		vim.api.nvim_create_user_command("FR", function()
			builtin.oldfiles()
		end, {})

		-- ===== セッション系 =====
		vim.api.nvim_create_user_command("FP", function()
			telescope.extensions.persisted.persisted()
		end, {})

		-- Leader キー (デフォルトで "\") を使ったショートカット
		vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true }) -- 保存
		vim.keymap.set("n", "<leader>sl", ":SessionLoad<CR>", { noremap = true, silent = true }) -- 復元
		vim.keymap.set("n", "<leader>sp", ":Telescope persisted<CR>", { noremap = true, silent = true }) -- 一覧
		vim.keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { noremap = true, silent = true }) -- 削除
	end,
}
