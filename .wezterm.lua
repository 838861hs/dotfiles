local wezterm = require 'wezterm'

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local bg = "#5c6d74"
  local fg = "#e6e6e6"

  if tab.is_active then
    bg = "#ae8b2d"
    fg = "#ffffff"
  elseif hover then
    bg = "#7a8a91"
    fg = "#ffffff"
  end

  local edge_fg = bg
  local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 2) .. " "

  return {
    { Background = { Color = "none" } },
    { Foreground = { Color = edge_fg } },
    { Text = SOLID_LEFT_ARROW },

    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = title },

    { Background = { Color = "none" } },
    { Foreground = { Color = edge_fg } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)


return {
  default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "/home/philoaki", "tmux", "new-session", "-A", "-s", "main" },
  font = wezterm.font_with_fallback({
    "UDEV Gothic 35NF",
    "Meiryo", -- 日本語フォールバック（お好みで）
  }),
  font_size = 11.0,  -- デフォルトは 12.0 前後
  
  -- 背景透過（0.0=透明、1.0=不透明）
  window_background_opacity = 0.8,

  -- Windowsの場合の背景ぼかし
  -- win32_system_backdrop = "Acrylic", -- もしくは "Mica" / "Tabbed" / "Disable"

  -- タブバーの見た目
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  window_decorations = "RESIZE",
  window_frame = { inactive_titlebar_bg="none", active_titlebar_bg="none" },
  window_background_gradient = { colors = {"#000000"} },
  show_new_tab_button_in_tab_bar = false,

  colors = {
  tab_bar = {
      inactive_tab_edge = "none",
    },
  },

  keys = {
    -- 新しいタブを開く
    {
      key = "t",
      mods = "CTRL",
      action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    -- 現在のタブを閉じる
    {
      key = "w",
      mods = "CTRL",
      action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    -- タブ切り替え (Ctrl+1～9)
    { key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(-1) }, 
    {
      key = 'v',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'Clipboard',
    },
    {
      key = 'c',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'Clipboard',
    },
  
  },
    -- タブやペインを閉じるときの確認ダイアログを無効化
  window_close_confirmation = "NeverPrompt",

}
