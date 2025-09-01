-- lua/user/plugin/conform.lua

return {
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
}
