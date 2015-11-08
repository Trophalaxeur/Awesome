-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/mine/theme.lua")


icons_dir = awful.util.getdir("config") .. "/icons/"

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = os.getenv("BROWSER") or "firefox"
files = "pcmanfm"

font = 'Anonymous Pro 9'

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
	names = {"main","dev",3,4},
	layout = { layouts[2], layouts[2], layouts[1], layouts[5]
       }}

tags_alt = {
	names = {"web","skype"},
	layout = { layouts[1], layouts[1]
	}}

tags[1] = awful.tag(tags.names, 1, tags.layout)

if screen.count()>1 then
	for s = 2, screen.count() do
	    -- Each screen has its own tag table.
	    tags[s] = awful.tag(tags_alt.names, s, tags_alt.layout)
	end
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mylibreofficemenu = {
   { "Main", 'libreoffice', icons_dir .. "apps/libreoffice_libo.png"},
   { "Writer", 'libreoffice --writer', icons_dir .. "apps/libreoffice_writer.png"},
   { "Calc", 'libreoffice --calc', icons_dir .. "apps/libreoffice_calc.png"},
   { "Impress", 'libreoffice --impress', icons_dir .. "apps/libreoffice_impress.png"},
   { "Draw", 'libreoffice --draw', icons_dir .. "apps/libreoffice_draw.png"},
   { "Base", 'libreoffice --base', icons_dir .. "apps/libreoffice_base.png"},
   { "Math", 'libreoffice --math', icons_dir .. "apps/libreoffice_math.png"}
}

mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "LibreOffice", mylibreofficemenu, icons_dir .. "apps/libreoffice.png"},
    { "Gimp", "gimp", icons_dir .. "apps/Gimp.png"},
		{ "Skype", "skype&", icons_dir .. "apps/Skype.png"},
    { "Terminal", terminal, icons_dir .. "apps/Terminal.png"},
    { "Web Browser", browser, icons_dir .. "apps/Firefox.png" }
  }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


------------------------------------------------------------------------------------------
--	START WIBOX CONFIGURATION
------------------------------------------------------------------------------------------

-- {{{ Wibox

-- Separators
spacer    = wibox.widget.textbox()
separator = wibox.widget.textbox()
shizu = wibox.widget.textbox()
shatzi = wibox.widget.textbox()
spacer.text     = "              "
separator.text  = "|"
shizu.text = "   "
shatzi.text = " "

-------------------------------------
-- Create a batwidget
-------------------------------------
-- Initialize widget
--batwidget = wibox.widget.textbox()

--batimg = wibox.widget.imagebox()
--batimg:set_image(awful.util.getdir("config") .. "/icons/battery.png")

-- Register widget
--vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 21, "BAT0")

-------------------------------------
-- gmail widget and tooltip
-------------------------------------
mygmail = wibox.widget.textbox()
gmail_t = awful.tooltip({ objects = { mygmail },})

mygmailimg = wibox.widget.imagebox()
mygmailimg:set_image(icons_dir .. "mail.png")

vicious.register(mygmail, vicious.widgets.gmail,
                function (widget, args)
                    gmail_t:set_text(args["{subject}"])
                    gmail_t:add_to_object(mygmailimg)
                    return args["{count}"]
                 end, 120) 
                 --the '120' here means check every 2 minutes.



-------------------------------------
-- Volume widget (broken)
-------------------------------------
--volumecfg = {}
--volumecfg.cardid  = 0
--volumecfg.channel = "Master"
--volumecfg.widget = wibox.widget.textbox({name = "volumecfg.widget", align = "right" })
--volumecfg.widget = wibox.widget.textbox()

--volumecfg_t = awful.tooltip({ objects = { volumecfg.widget },})
--volumecfg_t:set_text("Volume")

myvolimg = wibox.widget.imagebox()
myvolimg:set_image(icons_dir .. "vol.png")

-- command must start with a space!
--volumecfg.mixercommand = function (command)
--       local fd = io.popen("amixer -c " .. volumecfg.cardid .. command)
--       local status = fd:read("*all")
--       fd:close()

--       local volume = string.match(status, "(%d?%d?%d)%%")
--       volume = string.format("% 3d", volume)
--       status = string.match(status, "%[(o[^%]]*)%]")
--       if string.find(status, "on", 1, true) then
--               volume = volume .. "%"
--       else
--               volume = volume .. "M"
--       end
--       volumecfg.widget.text = volume
--end
--volumecfg.update = function ()
--       volumecfg.mixercommand(" sget " .. volumecfg.channel)
--end
--volumecfg.up = function ()
--       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 1%+")
--end
--volumecfg.down = function ()
--       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 1%-")
--end
--volumecfg.toggle = function ()
--       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " toggle")
--end
--volumecfg.widget:buttons({
--       button({ }, 4, function () volumecfg.up() end),
--       button({ }, 5, function () volumecfg.down() end),
--       button({ }, 1, function () volumecfg.toggle() end)
--})
--volumecfg.update()


-------------------------------------
-- Volume widget
-------------------------------------
volumewidget=wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
	function(widget, args)
		local label={["♫"]="O",["♪"]="M"}
--		local label={["X"]="O",["J"]="M"}
		return "Volume: " .. args[1] .. "% State: "-- .. label[args[2]]
	end, 2, "Headphone")



-------------------------------------
-- Pacman Widget
-------------------------------------
pacwidget = wibox.widget.textbox()

pacimg = wibox.widget.imagebox()
pacimg:set_image(icons_dir .. "pacman.png")

pacwidget_t = awful.tooltip({ objects = { pacwidget},})

vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("pacman -Qu")
                    local str = ''

                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    s:close()
                    return "UPDATES: " .. args[1]
                end, 1800, "Arch")
                --'1800' means check every 30 minutes

-------------------------------------
-- Weather widget
-------------------------------------
weatherwidget = wibox.widget.textbox()
weather_t = awful.tooltip({ objects = { weatherwidget },})

weatherimg = wibox.widget.imagebox()
weatherimg:set_image(icons_dir .. "dish.png")

vicious.register(weatherwidget, vicious.widgets.weather,
                function (widget, args)
                    weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
        
            return '<span font="' .. font .. '" color="#EEEEEE" background="#694C6E">  ' .. args["{tempc}"] .. '°C  </span>'
                end, 1800, "LFBO")
                --'1800': check every 30 minutes.
                --'LFPI': Issy les moulineaux
                --'LFPG': Paris CDG
                --'LFPO': Paris Orly
                --'LFBO': Toulouse
                --Autre (France) : http://en.wikipedia.org/wiki/List_of_airports_by_ICAO_code:_L#LF_.E2.80.93_France


-------------------------------------
-- memory (textbox)
-------------------------------------
--memwidget = wibox.widget.textbox()
--vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)         

memimg = wibox.widget.imagebox()
memimg:set_image(icons_dir .. "mem.png")

-------------------------------------
-- Memory usafe (progressbar)
-------------------------------------
-- Initialize widget
memwidget=awful.widget.progressbar()
-- Progressbar properties
memwidget:set_width(8)
memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color({type="linear",from={0,0},to={10,0},stops={{0,"#AECF96"},{0.5,"#88A175"},{1,"#FF5656"}}})
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)


-------------------------------------
-- fs root
-------------------------------------
fswidgetroot = wibox.widget.textbox()
vicious.register(fswidgetroot, vicious.widgets.fs, "/root: ${/ used_gb} / ${/ avail_gb} gb", 37)

-------------------------------------
-- fs home
-------------------------------------
fswidgethome = wibox.widget.textbox()
vicious.register(fswidgethome, vicious.widgets.fs, "/home: ${/home used_gb} / ${/home avail_gb} gb", 37)
-------------------------------------
-- fs var
-------------------------------------
-- fswidgetvar = wibox.widget.textbox()
-- vicious.register(fswidgetvar, vicious.widgets.fs, "/var: ${/var used_gb} / ${/var avail_gb} gb", 37)

-------------------------------------
-- fs img
-------------------------------------
fsimg = wibox.widget.imagebox()
fsimg:set_image(icons_dir .. "fs.png")

-------------------------------------
-- Network usage widget
-------------------------------------
dnicon = wibox.widget.imagebox()
upicon = wibox.widget.imagebox()
dnicon:set_image(icons_dir .. "down.png")
upicon:set_image(icons_dir .. "up.png")

netwidget = wibox.widget.textbox()
-- Register widget
vicious.register(netwidget, vicious.widgets.net, "${enp12s0 up_kb}kb/s / ${enp12s0 down_kb}kb/s", 1)

-------------------------------------
-- MDP widget
-------------------------------------

-- Initialize widget
 mpdwidget = wibox.widget.textbox()
-- Register widget
 vicious.register(mpdwidget, vicious.widgets.mpd,
     function (widget, args)
         if args["{state}"] == "Stop" then 
             return " - "
         else 
             return args["{Artist}"]..' - '.. args["{Title}"]
        end
    end, 10)

-------------------------------------
--CPU widget
-------------------------------------
-- Initialize widget
cpuwidget = awful.widget.graph()
-- Graph properties
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({type="linear",from={0,0},to={10,0},stops={{0,"FF5656#"},{0.5,"#88A175"},{1,"#AECF96"}}})
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

--cpuwidget = wibox.widget.textbox()
--Register widget
--vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")

cpuimg = wibox.widget.imagebox()
cpuimg:set_image(icons_dir .. "cpu.png")



-------------------------------------
-- Textclock
-------------------------------------
-- Create a textclock widget
--mytextclock = awful.widget.textclock()

-- Initialize widget
datewidget = wibox.widget.textbox()
local strf = '<span font="' .. font .. '" color="#EEEEEE" background="#777E76">  %b %d %R  </span>'
-- Register widget
vicious.register(datewidget,vicious.widgets.date, strf, 20)

-------------------------------------
-- systray
-------------------------------------
-- Create a systray
mysystray = wibox.widget.systray()




mywibox = {}
mywiboxbottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, {
      tasklist_disable_icon = true,
      bg_image_normal = beautiful.tasklist_bg_normal_img,
      bg_image_focus = beautiful.tasklist_bg_focus_img
    })


    -- create TOP WiBox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width=0, height=16})

    -- Widgets that are aligned to the left
    local upper_left_layout=wibox.layout.fixed.horizontal()
    upper_left_layout:add(mylauncher)
    upper_left_layout:add(mytaglist[s])
    upper_left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local upper_right_layout=wibox.layout.fixed.horizontal()
    if s==1 then upper_right_layout:add(mysystray) end
--    upper_right_layout:add(mytextclock)
    upper_right_layout:add(datewidget)
    upper_right_layout:add(shatzi) 
    upper_right_layout:add(weatherwidget)
    upper_right_layout:add(shatzi)
    upper_right_layout:add(weatherimg)
    upper_right_layout:add(shatzi)
    upper_right_layout:add(mygmail)
    upper_right_layout:add(shatzi)
    upper_right_layout:add(mygmailimg)
    upper_right_layout:add(shatzi)
    upper_right_layout:add(mylayoutbox[s])
    
    -- Now, bring it all together (with the tasklist in the middle)
    local upper_layout = wibox.layout.align.horizontal()
    upper_layout:set_left(upper_left_layout)
    upper_layout:set_middle(mytasklist[s])
    upper_layout:set_right(upper_right_layout)

   -- Add upper layout to the wibox
   mywibox[s]:set_widget(upper_layout)


   -- Create BOTTOM WiBox
   mywiboxbottom[s] = awful.wibox({ position = "bottom", screen = s, border_width=0, height=16})

	-- Widgets that are aligned to the left
	local bottom_left_layout=wibox.layout.fixed.horizontal()
	bottom_left_layout:add(spacer)
	bottom_left_layout:add(mpdwidget)

   -- Widgets that are aligned to the middle
   local bottom_middle_layout=wibox.layout.fixed.horizontal()
   bottom_middle_layout:add(pacimg)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(pacwidget)
   bottom_middle_layout:add(spacer)
   bottom_middle_layout:add(memimg)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(memwidget)
   bottom_middle_layout:add(spacer)
   bottom_middle_layout:add(cpuimg)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(cpuwidget)
   bottom_middle_layout:add(spacer)
   bottom_middle_layout:add(fsimg)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(fswidgetroot)
   bottom_middle_layout:add(spacer)
   bottom_middle_layout:add(fsimg)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(fswidgethome)
--   bottom_middle_layout:add(spacer)
--   bottom_middle_layout:add(fsimg)
--   bottom_middle_layout:add(shatzi)
--   bottom_middle_layout:add(fswidgetvar)
   bottom_middle_layout:add(spacer)
   bottom_middle_layout:add(upicon)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(netwidget)
   bottom_middle_layout:add(shatzi)
   bottom_middle_layout:add(dnicon)

	-- Widgets that are aligned on the right
	local bottom_right_layout=wibox.layout.fixed.horizontal()
	bottom_right_layout:add(myvolimg)
	bottom_right_layout:add(volumewidget)
	bottom_right_layout:add(spacer)

   -- Now, bring it all together (with the tasklist in the middle)
   local bottom_layout = wibox.layout.align.horizontal()
	bottom_layout:set_left(bottom_left_layout)
	bottom_layout:set_middle(bottom_middle_layout)
	bottom_layout:set_right(bottom_right_layout)

   -- Add upper layout to the wibox
   mywiboxbottom[s]:set_widget(bottom_layout)


    -- Add widget to the wibox - order matters
--    mywibox[s].widgets = {
--        {
--            mylauncher,
--            mytaglist[s],
--            mypromptbox[s],
--            layout = awful.widget.layout.horizontal.leftright
--        },
--        s == 1 and mysystray or nil,
--        mytextclock, volumecfg.widget, myvolimg, shatzi, weatherwidget, shatzi, weatherimg, shatzi, mygmail, shatzi, mygmailimg, shatzi, mpdwidget,
--        mytasklist[s],
--        layout = awful.widget.layout.horizontal.rightleft
--    }


	-- create BOTTOM wibox
--	mywiboxbottom[s] = awful.wibox({ position = "bottom", screen = s})

	-- Add widget to the wibox - order matters
--	mywiboxbottom[s].widgets = {
--		shizu, shizu, shizu, shizu, shizu, shizu, shizu, batimg, shatzi, batwidget, spacer, pacimg, shatzi, pacwidget, spacer, memimg, shatzi, memwidget, spacer, cpuimg, shatzi, cpuwidget, spacer, fsimg, shatzi, fswidgetroot, spacer, fsimg, shatzi, fswidgethome, spacer, fsimg, shatzi, fswidgetvar, spacer, upicon, shatzi, netwidget, shatzi, dnicon,
--		layout = awful.widget.layout.horizontal.leftright
--	}
end
-- }}}


------------------------------------------------------------------------------------------
--	END WIBOX CONFIGURATION
------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------
--	START MOUSE BINDINGS
------------------------------------------------------------------------------------------

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Control"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Control"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Shift" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Shift" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),

    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    --Set autostart urxvt tests 
     { rule = { instance = "autostartRightShell" },
       properties = { tag = tags[1][1] } },
     { rule = { instance = "test2" },
       properties = { tag = tags[1][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            -- client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = true
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
--        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
--        right_layout:add(awful.titlebar.widget.stickybutton(c))
--        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("left")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- {{{ Fonction de démarrage automatique des shells (on ne les lance qu'une seule fois)
-- Source : http://awesome.naquadah.org/wiki/Autostart
function run_once(prg,arg_string,pname,screen)
  if not prg then
    do return nil end
  end

  if not pname then
    pname = prg
  end

  if not arg_string then
    awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
  else
    awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
  end
end

run_once("urxvt","-title 'Secondary' -name 'autostartRightShell'");
run_once("urxvt","-title 'Music' -name 'autostartRightShell'");
run_once("urxvt","-title 'Main' -name 'autostartRightShell'");
-- }}}
