source ~/.antigen/antigen.zsh

if [ -z ${ZSH_CACHE_DIR} ]; then
    ZSH_CACHE_DIR="${HOME}/.cache"
fi

setopt HIST_IGNORE_DUPS

## EXPORT
# change the size of history files
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTTIMEFORMAT="[%d.%m.%y] %T   "
export TERM=xterm-256color
export CLICOLOR=1
export PATH=$PATH:$HOME/bin
# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='nano'

## ALIAS
alias updot="cd ~/.dotfiles && git remote set-url origin https://github.com/Connexeon/dotfiles.git && git pull origin master && ./install"

alias top2="glances"
alias nn="nano"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls="ls -GFh"

# Same as above, but in long listing format
alias ll="ls -GFhl"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Centminmod
alias cmdir='pushd /usr/local/src/centminmod'
alias postfixlog='pflogsumm -d today --verbose_msg_detail /var/log/maillog'

# git
alias update-submodules="git submodule foreach 'git checkout master && git pull origin master'"

# chmod
alias rw-='chmod 600'
alias rwx='chmod 700'
alias r--='chmod 644'
alias r-x='chmod 755'


## FUNCTIONS
function console {
  if [[ $# > 0 ]]; then
    query=$(echo "$*" | tr -s ' ' '|')
    tail -f /var/log/messages|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/messages
  fi
}

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo declared above.
antigen bundles <<EOBUNDLES
    oldratlee/hacker-quotes
    git
    pip
    compleat
    git-extras
    git-flow
    web-search
    n98-magerun
    voronkovich/mysql.plugin.zsh
    tugboat
    mafredri/zsh-async
    unixorn/autoupdate-antigen.zshplugin
    laravel
    laravel5
    symfony2
    systemd
    history
    djui/alias-tips
    z
    yum
    systemadmin
    rsync
    cp
    command-not-found
    autojump
    colorize
    common-aliases
    redis-cli
    supercrabtree/k
    extract
EOBUNDLES

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
    # None so far...
    if [[ $DISTRO == 'CentOS' ]]; then
        antigen bundle centos
    elif [[ $DISTRO == 'Ubuntu' ]]; then
        antigen bundle ubuntu
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi


# Fish-like suggestions bundle
antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle zsh-users/zsh-history-substring-search
#antigen bundle tarruda/zsh-autosuggestions

antigen bundle zsh-users/zaw

# Load the theme.
#antigen theme bhilburn/powerlevel9k powerlevel9k
#antigen theme halfo/lambda-mod-zsh-theme lambda-mod
#antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply

source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)

# KEYBINDING

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive
bindkey '^T' autosuggest-toggle

# Keybindings home/end/...
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal

# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey '^R' zaw-history
bindkey '^X' zaw

# Source a local zshrc if it exists.
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
