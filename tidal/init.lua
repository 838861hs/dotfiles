vim.opt.number = true

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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

-- Plugins
require("lazy").setup({
  {
    "jbfits/cycles.nvim",
    opts = {
      boot = {
        tidal = {
          file = vim.fn.expand("~/dotfiles/tidal/BootTidal.hs"),
        },
        sclang = {
          enabled = false,
        },
      },
    },
  },
})
vim.keymap.set("n", "<S-CR>", function()
  require("cycles").api.send_line()
end, { desc = "Send current line to Tidal" })
