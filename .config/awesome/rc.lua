-- ~/.config/awesome: Awesome WM configuration

-- {{{ Requires
-- Awesome libraries
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
require("awful.autofocus")

require(".error")                                   -- error handling
-- }}}

-- {{{ Theme
beautiful.init("theme.lua")
for s = 1, screen.count() do
    gears.wallpaper.maximized("/home/blami/.config/awesome/wallpaper/" .. s .. ".jpg", s, false)
end
-- }}}

-- {{{ Screens
-- }}}

-- {{{ Layouts
layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max
}
-- }}}

-- {{{ Tags
tags = {}
for i = 1, screen.count() do
    tags[i] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 }, i, layouts[1])
end

-- Display only given tag
function tag_viewonly(i)
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
        awful.tag.viewonly(tag)
    end
end
-- }}}

-- {{{ Clients
-- Raise next client
function client_cycle(i)
    awful.client.focus.byidx(i)
    if client.focus then
        client.focus:raise()
    end
end
-- Raise previous client
-- }}}

-- {{{ Menus
-- Root menu
menu_root = awful.menu({ items = {
    { "term"        , "x-terminal-emulator" },
    { "www-browser" , "x-www-browser" },
    { "ssh"         , {} },
    { "apps"        , {} },
    { "conf"        , {} },
    { "lock"        , "/usr/bin/xscreensaver-command -lock" },
    { "restart"     , awesome.restart },
    { "logout"      , awesome.quit }
}})
-- }}}
-- }}}

-- {{{ Keybindings
-- Modifier keys
local mod = "Mod1"
local sup = "Mod4"
local shift = "Shift"
local ctrl = "Control"

-- Mouse bindings
global_mouse = awful.util.table.join(
    awful.button({  },                  3,              function () menu_root:toggle() end)
)

client_mouse = awful.util.table.join(
    awful.button({ },                   1,              function (c) client.focus = c; c:raise() end),
    awful.button({ mod },               1,              awful.mouse.client.move),
    awful.button({ mod },               3,              awful.mouse.client.resize)
)

-- Key bindings
global_keys =  awful.util.table.join(
    -- Screens
    --awful.key(   { mod },

    -- Tags
    awful.key(   { mod },               "Left",         awful.tag.viewprev),
    awful.key(   { mod },               "Right",        awful.tag.viewnext),
    awful.key(   { mod },               "BackSpace",    awful.tag.history.restore),

    awful.key(   { mod },               "#10",          function () tag_viewonly(1) end),
    awful.key(   { mod },               "#11",          function () tag_viewonly(2) end),
    awful.key(   { mod },               "#12",          function () tag_viewonly(3) end),
    awful.key(   { mod },               "#13",          function () tag_viewonly(4) end),
    awful.key(   { mod },               "#14",          function () tag_viewonly(5) end),
    awful.key(   { mod },               "#15",          function () tag_viewonly(6) end),
    awful.key(   { mod },               "#16",          function () tag_viewonly(7) end),
    awful.key(   { mod },               "#17",          function () tag_viewonly(8) end),
    awful.key(   { mod },               "#18",          function () tag_viewonly(9) end),
    awful.key(   { mod },               "#19",          function () tag_viewonly(0) end),

    -- Clients
    awful.key(   { mod },               "Tab",          function () client_cycle(1) end),
    awful.key(   { mod, shift },        "Tab",          function () client_cycle(-1) end),    

    -- Layout
    awful.key(   { mod },               "Space",        function () awful.layout.inc(l_screen.layouts, 1) end),

    -- Progs
    awful.key(   { sup },               "l",            function () awful.util.spawn("/usr/bin/xscreensaver-command -lock") end),
    awful.key(   { },                   "XF86ScreenSaver", function () awful.util.spawn("/usr/bin/xscreensaver-command -lock") end),
    awful.key(   { mod },               "Return",       function () awful.util.spawn("x-terminal-emulator") end),
    awful.key(   { mod, shift },        "Return",       function () awful.util.spawn("x-www-browser") end)
)

client_keys = awful.util.table.join(
    awful.key(   { mod },               "F4",           function (c) c:kill() end)
)
-- }}}

-- {{{ Rules
-- Apply global mouse and key bindings
root.buttons(global_mouse)
root.keys(global_keys)

awful.rules.rules = {
    { rule = {}, properties = {
        border_width = 2,
        focus = awful.client.focus.filter,
        raise = true,
        buttons = client_mouse,
        keys = client_keys
    }}
}
-- }}}

-- {{{ Signals
client.connect_signal("manage", function (c, startup)
    -- Sloppy focus
    c:connect_signal("mouse::enter", function (c)
        if awful.client.focus.filter(c) then client.focus = c end
    end)
end)
-- }}}
