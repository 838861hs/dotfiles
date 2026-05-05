-- lua/user/plugin/colorscheme.lua

-- everforest テーマを読み込む設定
return {
  {
	"sainnhe/everforest",
  priority = 1000,
	config = function()
    vim.g.everforest_backgroud = 'hard',
    vim.cmd.colorscheme("everforest")
    vim.api.nvim_set_hl(0,"Visual", {
      bg = "#5f6d3e",
      fg = "NONE",
    })

    vim.api.nvim_set_hl(0,"CursorLine",{
      bg = "#2f383e",
    })
	end,
  }
}
