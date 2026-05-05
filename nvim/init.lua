-- =======================
-- yankをシステムクリップボードにする
-- =======================
vim.opt.clipboard = "unnamedplus"

-- =======================
-- insert → normalに切り替え設定
-- =======================
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

-- ======================
-- 行の移動 (vim-move)
-- ======================
vim.g.move_map_keys = 0 -- デフォルトのキー割り当てを無効化

-- Ctrl+Alt+↓ / ↑ で行を上下に移動
vim.keymap.set("n", "<C-A-Down>", "<Plug>MoveLineDown", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-Up>", "<Plug>MoveLineUp", { noremap = true, silent = true })

-- ======================
-- 行番号の設定
-- ======================
vim.opt.relativenumber = true
vim.opt.number = true

-- ======================
-- メイン設定のロード
-- ======================
require("plugins") -- プラグイン管理 (lazy.nvim)
require("user.options") -- 基本設定（行番号、インデント幅など）
require("user.keymaps") -- キーマップ設定（分割、Git、Telescopeなど）

-- ======================
-- coc言語設定
-- ======================
vim.g.coc_global_extensions = {
	"coc-tsserver",
	"coc-html",
	"coc-css",
	"coc-emmet",
	"coc-json",
	"coc-prettier",
}

-- ======================
-- インデント設定（2スペース）
-- ======================
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
-- ======================
-- 補完 (coc.nvim + emmet)
-- ======================
local function check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Tab: 補完メニューが出てたら「確定」(=Emmet展開もここで起きる)
vim.keymap.set("i", "<Tab>", function()
	if vim.fn["coc#pum#visible"]() == 1 then
		return vim.fn["coc#pum#confirm"]()
	end
	if check_back_space() then
		return "\t"
	end
	-- ここで補完/Emmet候補を出す
	return vim.fn["coc#refresh"]()
end, { expr = true, noremap = true, silent = true })

-- ======================
-- ターミナル操作
-- ======================
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n><C-w>k]], { buffer = true, noremap = true, silent = true })
	end,
})

-- ======================
-- デバッグ用: 補完メニューが表示されているか確認
-- ======================
vim.keymap.set("n", "<leader>pv", function()
	print(vim.fn["coc#pum#visible"]())
end)
-- ======================
--  保存時にカーソル位置を復元する設定
-- ======================
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.b.cursor_pos = vim.api.nvim_win_get_cursor(0)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		if vim.b.cursor_pos then
			pcall(vim.api.nvim_win_set_cursor, 0, vim.b.cursor_pos)
			vim.b.cursor_pos = nil
		end
	end,
})

-- ======================
-- ejsのファイルタイプ設定
-- ======================
vim.filetype.add({
	extension = {
		ejs = "html",
	},
})
