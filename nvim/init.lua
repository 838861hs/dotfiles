--- ======================
-- 行の移動 (vim-move)
-- ======================
vim.g.move_map_keys = 0 -- デフォルトのキー割り当てを無効化

-- Ctrl+Alt+↓ / ↑ で行を上下に移動
vim.keymap.set("n", "<C-A-Down>", "<Plug>MoveLineDown", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-Up>", "<Plug>MoveLineUp", { noremap = true, silent = true })

-- ======================
-- メイン設定のロード
-- ======================
require("user.options") -- 基本設定（行番号、インデント幅など）
require("user.keymaps") -- キーマップ設定（分割、Git、Telescopeなど）
require("plugins") -- プラグイン管理 (lazy.nvim)

-- ======================
-- 補完 (coc.nvim + emmet)
-- ======================
-- Tab / Shift+Tab で補完候補を移動
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true })

-- Enter で補完確定 or emmet 展開
vim.api.nvim_set_keymap(
	"i",
	"<CR>",
	'pumvisible() ? coc#_select_confirm() : emmet#expandAbbrIntelligent("<CR>")',
	{ expr = true, noremap = true }
)

-- ======================
-- ターミナル操作
-- ======================
-- TermOpen イベント時:
-- <Esc> を押すとノーマルモードに戻り、
-- さらに <C-w>k で直前のエディタペインへフォーカスを戻す
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n><C-w>k]], { buffer = true, noremap = true, silent = true })
	end,
})
