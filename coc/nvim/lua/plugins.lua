local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"mattn/emmet-vim",
		lazy = false, -- 起動時に読み込む（補完で使うため）
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- 保存前に整形
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					-- フロントエンド系
					javascript = { "prettierd", "prettier" },
					typescript = { "prettierd", "prettier" },
					json = { "prettierd", "prettier" },
					html = { "prettierd", "prettier" },
					css = { "prettierd", "prettier" },

					-- Lua
					lua = { "stylua" },

					-- シェル系
					sh = { "shfmt" },
					zsh = { "shfmt" },

					-- Python
					python = { "black" },
				},

				-- 保存時に自動フォーマット
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback", -- LSPが無いときだけformatter実行
				},
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = false, -- Enterキーのオートペア改行を無効化
			})
		end,
	},

	{
		"olimorris/persisted.nvim",
		config = function()
			require("persisted").setup({
				use_git_branch = true,
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "horizontal", -- 下ペインに出す
				size = 15,
			})
			-- ショートカット例: <leader>t でターミナル切り替え
			vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000, -- colorschemeは早めに読み込むため
		config = function()
			vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
				trigger_events = { "InsertLeave" }, -- Insertモード終了時に保存
				execution_message = { enabled = false }, -- 保存メッセージを非表示にする
			})
		end,
	},
	{
		"neoclide/coc.nvim",
		branch = "release",
		build = "npm install",
		lazy = false,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup()

			-- persisted.nvim の Telescope 拡張をロード
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
			-- Telescope からセッション一覧を選択 (FP)
			vim.api.nvim_create_user_command("FP", function()
				telescope.extensions.persisted.persisted()
			end, {})

			-- Leader キー (デフォルトで "\") を使ったショートカット
			vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true }) -- 保存
			vim.keymap.set("n", "<leader>sl", ":SessionLoad<CR>", { noremap = true, silent = true }) -- 復元
			vim.keymap.set("n", "<leader>sp", ":Telescope persisted<CR>", { noremap = true, silent = true }) -- 一覧
			vim.keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { noremap = true, silent = true }) -- 削除
		end,
	},
	{
		"matze/vim-move",
		lazy = false,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		lazy = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		lazy = false,
		opts = {
			indent = {
				char = "|",
			},
			whitespace = {
				remove_blankline_trail = false,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true, -- 行ごとに blame 表示
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gstatus", "Gcommit", "Gpush" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- アイコンを出すなら必要
		config = function()
			require("nvim-tree").setup({})

			-- キーマップ（ノーマルモード）
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
		end,
	},
})
