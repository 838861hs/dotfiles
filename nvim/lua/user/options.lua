--　基本設定
vim.opt.number = true -- 行番号表示
vim.opt.tabstop = 2 -- タブ幅
vim.opt.shiftwidth = 2 -- インデント幅
vim.opt.expandtab = true -- タブ→スペース
vim.opt.smartindent = true -- スマートインデント
vim.opt.cursorline = true -- 現在行をハイライト
vim.opt.termguicolors = true -- 24bitカラーサポート
vim.opt.confirm = true

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
