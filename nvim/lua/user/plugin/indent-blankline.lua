-- lua/user/plugin/indent-blankline.lua

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	lazy = false,
	opts = {
		indent = {
			char = "|", -- インデントガイドの記号
		},
		whitespace = {
			remove_blankline_trail = false,
		},
	},
}
