# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Neovim alias
alias nvim='nvim.appimage'

# source bashrc
alias source='source .bashrc'

# Update the packages
alias update='sudo apt update && sudo apt upgrade'

# miscellaneous
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias unfuckaudio='pulseaudio -k'
alias runmongo='docker run --name mymongo -d -p 27017:27017 mongo:latest'
alias server='ssh parsajr@147.160.139.143'
alias lab='ssh parsajr@192.168.1.50'
alias pn='pnpm'
alias displays='xrandr | grep " connected"'
alias c='clear'
