-- Awesome random theme function

-- Theme handling library
local beautiful = require("beautiful")

-- Choose and load a random theme from themedir
function rndtheme()
    -- {{{ Choose png
    local walls = {}
    for file in io.popen('ls '..walldir..'*png'):lines() do
        loglua("(II) Got a wallpaper: '" .. file .. "'")
        table.insert(walls, file)
    end

    math.randomseed(os.time()+#walls)
    rndwall = walls[math.random(#walls)]
    loglua("(II) Using '" .. rndwall .. "'")
    -- }}}
    -- {{{ Get vibrant palette
    colors = { lightmuted   = "#ffffff"
             , darkmuted    = "#000000"
             , vibrant      = "#ffffff"
             , lightvibrant = "#ffffff"
             , darkvibrant  = "#000000"
             , muted        = "#ffffff"
             }
    os.execute("chmod +x " .. bindir .. "vibrant")
    local v = pread(bindir .. "vibrant " .. rndwall)
    for key, value in v:gmatch("(%w+): (#%w+)") do
        loglua("(II) Got color: '" .. key .. "' -> '" .. value .. "'")
        colors[key] = value
    end
    -- }}}
    -- {{{ Generate Theme
    theme = {}
    theme.wallpaper  = rndwall
    theme.icon_theme = nil
    -- font
    theme.font          = "terminus 9"
    theme.font_key      = colors.lightvibrant
    theme.font_value    = colors.lightmuted
    -- bg
    theme.bg_normal     = colors.darkvibrant .. 'DD'
    theme.bg_focus      = colors.lightvibrant .. 'DD'
    theme.bg_urgent     = colors.vibrant
    theme.bg_minimize   = colors.darkmuted
    -- fg
    theme.fg_normal     = colors.lightvibrant
    theme.fg_focus      = colors.darkmuted
    theme.fg_minimize   = colors.muted
    -- border
    theme.useless_gap   = "2"
    theme.border_width  = "1"
    theme.border_normal = colors.darkvibrant
    theme.border_focus  = colors.lightvibrant
    theme.border_marked = colors.muted
    -- Taglist
    theme.taglist_squares_sel    = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
    theme.taglist_squares_unsel  = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
    theme.taglist_squares_resize = "false"
    -- Layout
    theme.layout_cornernw   = layoutdir.."/cornernww.png"
    theme.layout_fairh      = layoutdir.."/fairhw.png"
    theme.layout_fairv      = layoutdir.."/fairvw.png"
--    theme.layout_floating   = layoutdir.."/floatingw.png"
    theme.layout_magnifier  = layoutdir.."/magnifierw.png"
    theme.layout_max        = layoutdir.."/maxw.png"
--   theme.layout_fullscreen = layoutdir.."/fullscreenw.png"
    theme.layout_tilebottom = layoutdir.."/tilebottomw.png"
    theme.layout_tileleft   = layoutdir.."/tileleftw.png"
    theme.layout_tile       = layoutdir.."/tilew.png"
    theme.layout_tiletop    = layoutdir.."/tiletopw.png"
--    theme.layout_spiral     = layoutdir.."/spiralw.png"
--    theme.layout_dwindle    = layoutdir.."/dwindlew.png"
--    theme.layout_cornerne   = layoutdir.."/cornernew.png"
--    theme.layout_cornersw   = layoutdir.."/cornersww.png"
--    theme.layout_cornerse   = layoutdir.."/cornersew.png"
    -- }}}
    beautiful.init(theme)
end

--  1st call
rndtheme();

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 nu:
