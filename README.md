# Neovim Config (dotfiles)

## ディレクトリ構成

```text
~/.config/nvim/
├── init.lua # エントリーポイント
├── lua/
│ ├── user/
│ │ ├── options.lua # 基本設定（行番号、タブ幅、インデントなど）
│ │ ├── keymaps.lua # キーマップ設定
│ │ └── plugin/ # プラグイン設定を分割管理
│ │ ├── autopairs.lua # 自動括弧補完
│ │ ├── colorscheme.lua # カラースキーマ (Kanagawa)
│ │ ├── indent-blankline.lua# インデント可視化
│ │ ├── toggleterm.lua # ターミナル統合
│ │ ├── telescope.lua # ファジーファインダー
│ │ ├── gitsigns.lua # Git 行ごと表示
│ │ ├── fugitive.lua # Git 操作 (コミット/プッシュ等)
│ │ ├── auto-save.lua # 自動保存
│ │ ├── persisted.lua # セッション管理
│ │ ├── coc.lua # 補完エンジン (coc.nvim)
│ │ ├── conform.lua # フォーマッタ (Prettier, Stylua, etc.)
│ │ └── ufo.lua # 折りたたみ (VSCodeライク)
│ └── plugins.lua # lazy.nvim によるプラグイン登録
```


## 使用プラグイン一覧と役割

- **[lazy.nvim](https://github.com/folke/lazy.nvim)**  
  プラグインマネージャー。すべてのプラグインをここから読み込む。

- **[emmet-vim](https://github.com/mattn/emmet-vim)**  
  HTML / CSS 向けの Emmet 展開補完。

- **[coc.nvim](https://github.com/neoclide/coc.nvim)**  
  LSPクライアント + 補完エンジン。TypeScript, React, etc. の補完に使用。

- **[conform.nvim](https://github.com/stevearc/conform.nvim)**  
  保存時の自動フォーマット。  
  Prettier（フロントエンド）、Stylua（Lua）、shfmt（シェル）、black（Python）を利用。

- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)**  
  `()` `{}` `""` などの自動補完。

- **[persisted.nvim](https://github.com/olimorris/persisted.nvim)**  
  セッション管理。終了時のレイアウトや開いていたファイルを保存・復元。

- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)**  
  Neovim 内部でターミナルを起動できる。ホットキーで開閉可能。

- **[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)**  
  カラースキーマ。日本画風の落ち着いた配色。

- **[auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)**  
  Insert モード終了時に自動保存。

- **[vim-move](https://github.com/matze/vim-move)**  
  行やブロックを簡単に移動できる。キーを Ctrl+Alt+↑/↓ に設定。

- **[vim-visual-multi](https://github.com/mg979/vim-visual-multi)**  
  複数カーソル編集。

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**  
  ファイル検索 / live grep / oldfiles / セッション検索。  
  - `:FF` ファイル検索  
  - `:FG` Git管理下ファイル検索  
  - `:FS` live grep  
  - `:FR` 最近のファイル  
  - `:FP` セッション選択

- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**  
  行番号の左に `+`, `~`, `_` で Git の差分を表示。

- **[vim-fugitive](https://github.com/tpope/vim-fugitive)**  
  Neovim 内で Git 操作を可能にする。  
  - `:G` ステータス表示  
  - `:Gdiffsplit` 差分表示  
  - `:Gcommit` コミット  
  - `:Gpush` プッシュ

- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)**  
  ファイルエクスプローラ。`<leader>e` でトグル表示。

- **[nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)**  
  VSCode風のコード折りたたみ。  
  - `zc` で折りたたむ  
  - `zo` で展開  
  - `zR` で全展開  
  - `zM` で全折りたたみ  

---

## 特記事項

- プラグイン管理は **lazy.nvim** で統一。  
- 設定は `lua/user/plugin/` に分割して管理。  
- `.local/share/nvim` や `.cache` などのキャッシュは dotfiles に含めないこと。  
