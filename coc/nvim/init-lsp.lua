-- ~/.config/nvim/init.lua  (UTF-8, BOMなし)

-- ===== 基本表示 =====
vim.opt.termguicolors  = true
vim.opt.cursorline     = true
vim.opt.signcolumn     = "yes"
vim.opt.sidescrolloff  = 8
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = "powershell.exe -NoProfile -Command Get-Clipboard",
    ["*"] = "powershell.exe -NoProfile -Command Get-Clipboard",
  },
  cache_enabled = 0,
}
vim.cmd([[silent! packadd matchit]])

-- 空白の見える化 + トグル
vim.opt.list = true
vim.opt.listchars = { tab = "»·", trail = "•" }
vim.keymap.set("n","<leader>lw", function() vim.opt.list = not vim.opt.list:get() end,
  { desc = "Toggle whitespace" })

-- ===== lazy.nvim bootstrap =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ===== プラグイン =====
require("lazy").setup({
  -- Emmet（常時ロード）
  { "mattn/emmet-vim", lazy = false },

  -- マルチカーソル
  { "mg979/vim-visual-multi",branch = "master" },
  { "andymass/vim-matchup", event= "VeryLazy" },
  -- インデントガイド / 全角スペース / 末尾空白の削除
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "thinca/vim-zenspace", event = { "BufReadPost","BufNewFile" } },
  {
    "ntpeters/vim-better-whitespace",
    event = "BufReadPost",
    init = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.better_whitespace_filetypes_blacklist =
        { "diff","gitcommit","unite","qf","help","markdown","fugitive" }
    end,
  },

  -- ===== 補完（nvim-cmp + LuaSnip）=====
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i","s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i","s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- ===== Mason + LSP =====
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "html", "cssls", "ts_ls", "emmet_ls" }, -- csslsはscssも対応
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lsp = require("lspconfig")

      lsp.html.setup({ capabilities = capabilities })
      lsp.cssls.setup({ capabilities = capabilities })
      lsp.ts_ls.setup({ capabilities = capabilities }) -- tsserverの後継
      lsp.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html","css","scss","javascriptreact","typescriptreact" },
      })
    end,
  },
})

-- Emmet: 挿入モードで Ctrl+e で展開
vim.keymap.set("i", "<C-e>", "<Plug>(emmet-expand-abbr)", { silent = true, remap = true })

