-- ~/.config/nvim/lua/user/plugin/autopairs.lua
-- Enter のみ調整、Tab は触らない

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
			map_cr = false, -- autopairs に <CR> を自動設定させない
			check_ts = true,
		})

		-- Enter のみ coc.nvim と autopairs の共存設定
		_G.cr_action = function()
			if vim.fn.pumvisible() ~= 0 then
				return vim.fn["coc#pum#confirm"]()
			else
				return npairs.autopairs_cr()
			end
		end

		vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()", { expr = true, noremap = true })
	end,
}
