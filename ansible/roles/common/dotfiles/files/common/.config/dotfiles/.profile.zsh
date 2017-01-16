#!/usr/bin/zsh

source "$DOTFILES/.docker.zsh"
source "$DOTFILES/.vim.zsh"

export VISUAL="nvim"
export EDITOR="$VISUAL"
export TERM="xterm-256color"

alias :e=nvim
alias :E=nvim
alias ezsh='nvim $DOTFILES/.zshrc'

alias llf='ls -lAF'
alias ncm='ncmpcpp'

if [[ -d ~/bin ]]; then
    MYBINPATH="$HOME/bin"
    export PATH="$PATH:$MYBINPATH"
fi

if [[ -d ~/GitApps/bin ]]; then
    GITAPPSPATH="$HOME/GitApps/bin"
    export PATH="$PATH:$GITAPPSPATH"
fi

# Set up Go
export GOPATH=~/go
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# Set up Node
# TODO: investigate how to resolve this check
if [ -z "$npm_config_prefix" ]; then
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi
fi


function cddot {
    cd "$DOTFILES" || exit
}

if [[ -e ~/.fzf.zsh ]]; then
    function ff {
        nvim "$(fzf)"
    }
fi

# Fixes bracketed paste mode issues
alias fixpaste="echo \"\e[?2004l\""

alias untar="tar -zxvf"

# https://coderwall.com/p/_s_xda/fix-ssh-agent-in-reattached-tmux-session-shells
# https://babushk.in/posts/renew-environment-tmux.html
if [ -n "$TMUX" ]; then                                                                               
    function fixtmux {
        for key in VIM_THEME SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
            if (tmux show-environment | grep "^${key}" > /dev/null); then
                value=$(tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//")
                export ${key}="${value}"
            fi
        done
    }
else
    function fixtmux { true; }
fi

# TODO: change this preexec
function preexec {
    fixtmux
}

# http://stackoverflow.com/a/23002317/4396258
function abspath {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}