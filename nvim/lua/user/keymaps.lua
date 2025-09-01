-- ~/.config/nvim/lua/user/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- vsplit
-- ===== 分割操作 =====
map("n", "<A-v>", ":vsplit<CR>", opts) -- 縦分割
map("n", "<A-s>", ":split<CR>", opts) -- 横分割

-- ===== ウィンドウ移動 =====
map("n", "<A-h>", "<C-w>h", opts)
map("n", "<A-j>", "<C-w>j", opts)
map("n", "<A-k>", "<C-w>k", opts)
map("n", "<A-l>", "<C-w>l", opts)

-- ===== ウィンドウリサイズ =====
map("n", "<A-Left>", "<C-w><", opts)
map("n", "<A-Right>", "<C-w>>", opts)
map("n", "<A-Up>", "<C-w>+", opts)
map("n", "<A-Down>", "<C-w>-", opts)
map("n", "<A-=>", "<C-w>=", opts) -- 均等化

-- ===== ウィンドウ入れ替え =====
map("n", "<A-r>", "<C-w>r", opts)
map("n", "<A-R>", "<C-w>R", opts)

-- ===== ウィンドウの移動（画面内） =====
map("n", "<C-H>", "<C-w>H", opts)
map("n", "<C-L>", "<C-w>L", opts)
map("n", "<C-K>", "<C-w>K", opts)
map("n", "<C-J>", "<C-w>J", opts)

-- ===== ウィンドウの構成変更 =====
map("n", "<A-S-s>", "<C-w>t<C-w>K", opts)
map("n", "<A-S-v>", "<C-w>t<C-w>H", opts)

-- ===== NvimTree =====
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- ===== Git（Fugitive） =====
map("n", "<leader>gs", ":G<CR>", opts)
map("n", "<leader>gd", ":Gdiffsplit<CR>", opts)
map("n", "<leader>gvd", ":Gvdiffsplit<CR>", opts)

-- ===== Telescope =====
map("n", "<leader>ff", ":FF<CR>", opts) -- ファイル検索
map("n", "<leader>fg", ":FG<CR>", opts) -- Git管理下のファイル
map("n", "<leader>fs", ":FS<CR>", opts) -- テキスト検索
map("n", "<leader>fr", ":FR<CR>", opts) -- 最近開いたファイル

-- enter2回 → 時計回り
local last_enter = 0
map("n", "<cr>", function()
	local now = vim.loop.hrtime() / 1e6
	if now - last_enter < 500 then
		vim.cmd("wincmd w") -- 次のウィンドウへ
	end
	last_enter = now
end, opts)

-- ctrl+enter2回 → 逆回り
local last_ctrl_enter = 0
map("n", "<c-cr>", function()
	local now = vim.loop.hrtime() / 1e6
	if now - last_ctrl_enter < 500 then
		vim.cmd("wincmd w") -- 前のウィンドウへ
	end
	last_ctrl_enter = now
end, opts)
