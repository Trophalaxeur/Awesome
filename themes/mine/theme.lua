-------------------------------
-- My awesome theme based on --
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.this = os.getenv("HOME") .. "/.config/awesome/themes/mine"
theme.default = "/usr/share/awesome/themes/zenburn"
-- }}}

-- {{{ Wallpaper
--theme.wallpaper = theme.default .. "/background.jpg"
theme.wallpaper = theme.this .. "/background.jpg"
-- }}}

-- {{{ Styles
theme.font      = "Anonymous Pro 9"

-- {{{ Colors test
theme.fg_normal  = "#DAE5FF" -- Rouge
theme.fg_focus   = "#DAFFDF" -- Rose
theme.fg_urgent  = "#FFFC00" -- Jaune
theme.bg_normal  = "#3C4C77" -- Gris bleu
theme.bg_focus   = "#3C9825" -- Bleu ciel
theme.bg_urgent  = "#FFB300" -- Orange
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Colors (default)
--theme.fg_normal  = "#DCDCCC"
--theme.fg_focus   = "#F0DFAF"
--theme.fg_urgent  = "#CC9393"
--theme.bg_normal  = "#3F3F3F"
--theme.bg_focus   = "#1E2320"
--theme.bg_urgent  = "#3F3F3F"
--theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 2
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#00FF00"
-- }}}

-- {{{ Borders (default)
--theme.border_width  = 2
--theme.border_normal = "#3F3F3F"
--theme.border_focus  = "#6F6F6F"
--theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_fg_focus  = "#061F00"
theme.titlebar_fg_normal = "#6C719F"
theme.titlebar_bg_focus  = "#4B7D3E" -- Violet (856CC5)
theme.titlebar_bg_normal = "#12142E" -- Vert Pomme
-- }}}

-- {{{ Titlebars (default)
--theme.titlebar_bg_focus  = "#3F3F3F"
--theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 100
-- }}}

-- {{{ Tasklist
theme.tasklist_bg_normal_img = theme.this .. "/tasklist/tasklist_normal.png"
theme.tasklist_bg_focus_img = theme.this .. "/tasklist/tasklist_focus.png"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.default .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.default .. "/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Icons
theme.awesome_icon           = theme.default .. "/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.default .. "/layouts/tile.png"
theme.layout_tileleft   = theme.default .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.default .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.default .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.default .. "/layouts/fairv.png"
theme.layout_fairh      = theme.default .. "/layouts/fairh.png"
theme.layout_spiral     = theme.default .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.default .. "/layouts/dwindle.png"
theme.layout_max        = theme.default .. "/layouts/max.png"
theme.layout_fullscreen = theme.default .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.default .. "/layouts/magnifier.png"
theme.layout_floating   = theme.default .. "/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.default .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.default .. "/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme.default .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.default .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.default .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.default .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme.default .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.default .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.default .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.default .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme.default .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.default .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.default .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.default .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme.default .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.default .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.default .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
