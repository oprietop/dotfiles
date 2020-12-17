-- Awesome Functions

local gears     = require("gears")
local wibox     = require("wibox")
local naughty   = require("naughty")
local beautiful = require("beautiful")

-- {{{ fixutf8(text,text) # http://notebook.kulchenko.com/programming/fixing-malformed-utf8-in-lua
function fixutf8(s, replacement)
    local p, len, invalid = 1, #s, {}
    while p <= len do
        if p == s:find("[%z\1-\127]", p) then p = p + 1
        elseif p == s:find("[\194-\223][\128-\191]", p) then p = p + 2
        elseif p == s:find(       "\224[\160-\191][\128-\191]", p)
            or p == s:find("[\225-\236][\128-\191][\128-\191]", p)
            or p == s:find(       "\237[\128-\159][\128-\191]", p)
            or p == s:find("[\238-\239][\128-\191][\128-\191]", p) then p = p + 3
        elseif p == s:find(       "\240[\144-\191][\128-\191][\128-\191]", p)
            or p == s:find("[\241-\243][\128-\191][\128-\191][\128-\191]", p)
            or p == s:find(       "\244[\128-\143][\128-\191][\128-\191]", p) then p = p + 4
        else
            s = s:sub(1, p-1)..replacement..s:sub(p+1)
            table.insert(invalid, p)
        end
    end
    return s, invalid
end
-- {{{ Round number
-- }}}
function round(number)
    local high = math.ceil(number) - number
    if high >= .5 then
        return math.ceil(number)
    else
        return math.floor(number)
    end
end
-- }}}
-- {{{ Escape string
function escape(text)
    local xml_entities = {
        ["\""] = "&quot;",
        ["&"]  = "&amp;",
        ["'"]  = "&apos;",
        ["<"]  = "&lt;",
        [">"]  = "&gt;"
    }
    return text and text:gsub("[\"&'<>]", xml_entities)
end
-- }}}
-- {{{ Check if string is empty
function isempty(s)
    return s == nil or s == ''
end
-- }}}
-- {{{ Trim string
function trim(text)
    if not text then return end
    return (text:gsub("^%s*(.-)%s*$", "%1"))
end
-- }}}
-- {{{ Bold
function bold(text)
    return '<b>' .. text .. '</b>'
end
-- }}}
-- {{{ Italic
function italic(text)
    return '<i>' .. text .. '</i>'
end
-- }}}
-- {{{ Foreground color
function fgc(text,color)
    if not color then color = 'white' end
    if not text  then text  = 'NULL'  end
    return '<span color="'..color..'">'..text..'</span>'
end
-- }}}
-- {{{ Uppercase first letter of string
function ucfirst(str)
    return (str:gsub("^%l", string.upper))
end
-- }}}
-- {{{ Process read (io.popen wrapper)
function pread(cmd)
    if cmd and cmd ~= '' then
        local f, err = io.popen(cmd, 'r')
        if f then
            local s = f:read('*all')
            f:close()
            return s
        else
            loglua("(EE) pread failed reading '"..cmd.."', the error was '"..err.."'.")
        end
    end
end
-- }}}
-- {{{ File read (io.open wrapper)
function fread(cmd)
    if cmd and cmd ~= '' then
        local f, err = io.open(cmd, 'r')
        if f then
            local s = f:read('*all')
            f:close()
            return s
        else
            loglua("(EE) fread failed reading '"..cmd.."', the error was '"..err.."'.")
        end
    end
end
-- }}}
-- {{{ popup, a naughty wrapper
function popup(title,text,timeout,icon,position,fg,gb)
    -- pop must be global so we can find it and kill it anywhere
    pop = naughty.notify({ title     = title
                         , text      = text     or "All your base are belong to us."
                         , timeout   = timeout  or 0
                         , icon      = icon     or imgdir..'awesome-icon.png'
                         , icon_size = 39 -- 3 times our standard icon size
                         , position  = position or nil
                         , fg        = fg       or beautiful.fg_normal
                         , bg        = bg       or beautiful.bg_normal
                         })
end
-- }}}
-- {{{ Destroy all naughty notifications
function desnaug()
    for p,pos in pairs(naughty.notifications[mouse.screen]) do
        for i,notification in pairs(naughty.notifications[mouse.screen][p]) do
            naughty.destroy(notification)
            desnaug() -- call itself recursively until the total annihilation
        end
    end
end
-- }}}
-- {{{ Sets a random maximized wallpaper
function randwall(dir)
    local walls = {}
    for file in io.popen('ls '..dir):lines() do
        table.insert(walls, dir..file)
    end
    math.randomseed(os.time()+#walls)
    for s = 1, screen.count() do
        gears.wallpaper.maximized(walls[math.random(#walls)], s, true)
    end
end
-- }}}
-- {{{ Sets a random tiled wallpaper
function randtile(dir)
    local walls = {}
    for file in io.popen('ls '..dir):lines() do
        table.insert(walls, dir..file)
    end
    math.randomseed(os.time()+#walls)
    for s = 1, screen.count() do
        gears.wallpaper.tiled(walls[math.random(#walls)], s)
    end
end
-- }}}
-- {{{ Converts bytes to human-readable units, returns value (number) and unit (string)
function bytestoh(bytes)
    local tUnits={"K","M","G","T","P"} -- MUST be enough. :D
    local v,u
    for k = #tUnits,1,-1 do
        if math.fmod(bytes,1024^k) ~= bytes then v=bytes/(1024^k); u=tUnits[k] break end
    end
    return v or bytes,u or "B"
end
-- }}}
-- {{{ Returns all variables for debugging purposes
function dump(o)
    if type(o) == 'table' then
        local s = '{\n'
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. ', ['..k..'] = ' .. dump(v) .. '\n'
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
-- }}}

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 nu:
