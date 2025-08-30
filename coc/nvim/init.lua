--　基本設定
vim.opt.number = true -- 行番号表示
vim.opt.tabstop = 2 -- タブ幅
vim.opt.shiftwidth = 2 -- インデント幅
vim.opt.expandtab = true -- タブ→スペース
vim.opt.smartindent = true -- スマートインデント
vim.opt.cursorline = true -- 現在行をハイライト
vim.opt.termguicolors = true -- 24bitカラーサポート
vim.opt.confirm = true
-- vsplit設定
-- 縦分割
vim.keymap.set("n", "<A-v>", ":vsplit<CR>", { noremap = true, silent = true })

-- 横分割
vim.keymap.set("n", "<A-s>", ":split<CR>", { noremap = true, silent = true })

-- ウィンドウ移動 (Alt + hjkl)
vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true, silent = true })

-- 横幅の調整
vim.keymap.set("n", "<A-Left>", "<C-w><", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-w>>", { noremap = true, silent = true })

-- 高さの調整
vim.keymap.set("n", "<A-Up>", "<C-w>+", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-w>-", { noremap = true, silent = true })

-- 均等化
vim.keymap.set("n", "<A-=>", "<C-w>=", { noremap = true, silent = true })

-- ウィンドウ入れ替え（ローテーション）
vim.keymap.set("n", "<A-r>", "<C-w>r")
vim.keymap.set("n", "<A-R>", "<C-w>R")

-- 現在のウィンドウを上下左右に移動
vim.keymap.set("n", "<C-H>", "<C-w>H")
vim.keymap.set("n", "<C-L>", "<C-w>L")
vim.keymap.set("n", "<C-K>", "<C-w>K")
vim.keymap.set("n", "<C-J>", "<C-w>J")

-- 横並びに変更（K = 上に移動の応用）
vim.keymap.set("n", "<A-S-s>", "<C-w>t<C-w>K", { noremap = true, silent = true })

-- 縦並びに変更（H = 左に移動の応用）
vim.keymap.set("n", "<A-S-v>", "<C-w>t<C-w>H", { noremap = true, silent = true })

-- Enter2回 → 時計回り
local last_enter = 0
vim.keymap.set("n", "<CR>", function()
	local now = vim.loop.hrtime() / 1e6
	if now - last_enter < 500 then
		vim.cmd("wincmd w") -- 次のウィンドウへ
	end
	last_enter = now
end, { noremap = true, silent = true })

-- Ctrl+Enter2回 → 逆回り
local last_ctrl_enter = 0
vim.keymap.set("n", "<C-CR>", function()
	local now = vim.loop.hrtime() / 1e6
	if now - last_ctrl_enter < 500 then
		vim.cmd("wincmd W") -- 前のウィンドウへ
	end
	last_ctrl_enter = now
end, { noremap = true, silent = true })

-- clipboardにyankを入れる
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

require("plugins")

vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap(
	"i",
	"<CR>",
	'pumvisible() ? coc#_select_confirm() : emmet#expandAbbrIntelligent("<CR>")',
	{ expr = true, noremap = true }
)

-- デフォルトのマップを無効化
vim.g.move_map_keys = 0

-- ノーマルモードだけ上下移動を定義
vim.keymap.set("n", "<C-A-Down>", "<Plug>MoveLineDown", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-Up>", "<Plug>MoveLineUp", { noremap = true, silent = true })

-- ターミナルモードで <Esc> を押したらノーマルモードに戻す
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n><C-w>k]], { buffer = true, noremap = true, silent = true })
	end,
})
-- Fugitive: Git 差分表示用ショートカット
-- 縦分割で差分
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { noremap = true, silent = true })

-- 横分割で差分
vim.keymap.set("n", "<leader>gvd", ":Gvdiffsplit<CR>", { noremap = true, silent = true })
