[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap
[[ -f ~/.xresources ]] && xrdb -merge -I$HOME ~/.xresources
setxkbmap -option compose:sclk
exec gnome-session
