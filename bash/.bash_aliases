# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Press c to clear the terminal screen
alias c='clear'

# Fix Poping Sound
alias unfuckaudio='pulseaudio -k'

# Run MongoDB For Development On Port 27017
alias runmongo='docker run --name mymongo -d -p 27017:27017 mongo:latest'

# My Server
alias server='ssh parsajr@147.160.139.143'

# Home Server
alias lab='ssh parsajr@192.168.1.50'

# Launch Anki
alias anki='flatpak run net.ankiweb.Anki &'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'

# Neovim alias
alias v='nvim.appimage'

#helix
alias helix='hx'

alias source='source .bashrc'
