-- ~/.config/nvim/lua/user/plugin/autopairs.lua
-- nvim-autopairs の設定（coc.nvim + autopairs の Enter 共存）

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
			map_cr = true, -- Enterで改行インデント
			check_ts = true, -- Treesitter連携
		})

		-- coc.nvim と autopairs の共存用 <CR> マッピング
		_G.cr_action = function()
			if vim.fn.pumvisible() ~= 0 then
				-- 補完候補が出ている場合 → coc.nvimで確定
				return vim.fn["coc#_select_confirm"]()
			else
				-- それ以外は autopairs で改行インデント
				return npairs.autopairs_cr()
			end
		end

		vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()", { expr = true, noremap = true })
	end,
}
