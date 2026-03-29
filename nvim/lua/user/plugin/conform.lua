-- lua/user/plugin/conform.lua
return {
	"stevearc/conform.nvim",
	event = "BufWritePre", -- 保存前に整形
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				lua = { "stylua" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				python = { "black" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end,
}
