#!/bin/sh
# I log
errorlog="$HOME/.xsession.err"
if (cp /dev/null "$errorlog" 2> /dev/null)
then
    chmod 600 "$errorlog"
    exec > "$errorlog" 2>&1
    break
fi
# Workaround to make xorg care of the terminus font
xset +fp /usr/share/fonts/local
xset fp rehash
# Xmodmap para apple aluminum keyboard
if ( lsusb | grep -q "Apple, Inc. Aluminum Keyboard" ) ; then
    xmodmap $HOME/.config/xmodmap/apple_alu_mods.xmodmap
fi
# nasTests
[ -f "$(which xcompmgr)"   ] && xcompmgr -c -n &
[ -f "$(which urxvtd)"     ] && [ "$TERMINAL" = "urxvtc" ] && urxvtd -o -q -f
[ -f "$(which parcellite)" ] && parcellite &
[ -f "$(which nm-applet)"  ] && nm-applet &

# Exec WM
exec awesome > ~/.awesome.err 2>&1
