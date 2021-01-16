#!/usr/bin/zsh
export DOTFILES="$HOME/.config/dotfiles"

set -o vi
set -o emacs
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"
export VISUAL="nvim"
export EDITOR="$VISUAL"
export TERM="xterm-256color"
export VIM_THEME="gruvbox"
export PATH="$HOME/bin:$PATH"

# Set up keybindings (do this first because we want fzf to override defaults)
source "$DOTFILES/key-bindings.zsh"

# Set up Python / pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set up Go
export GOPATH=~/go
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"


export PATH="$DOTFILES/venv/bin:$PATH"
source "$DOTFILES/.docker.zsh"

# Set up fzf
if [[ -e ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if [[ `uname` == 'Darwin' ]]; then
  source $DOTFILES/.zshrc.osx
fi

# Set up npm bin
# https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-2-change-npms-default-directory-to-another-directory
# mkdir -p ~/.npm-global
# npm config set prefix '~/.npm-global'
# export PATH=~/.npm-global/bin:$PATH

#set up aactivator
eval "$(aactivator init)"

# Fixes bracketed paste mode issues
alias fixpaste="echo \"\e[?2004l\""
alias untar="tar -zxvf"
alias gst='git status'

# source npm
# http://stackoverflow.com/a/34071958/4396258
alias snpm='export PATH=$(npm bin):$PATH'

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

function cdmess {
    cd $(mktemp -d)
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

# http://vasir.net/blog/ubuntu/replace_string_in_multiple_files
# replace text in files
function rtif {
    if [ ! -d "$1" ]; then
        echo "$1 not a dir"
        return 1
    fi

    if [ -z "$2" ] || [ -z "$3" ]; then
        echo "operands empty"
        return 1
    fi

    grep -rlI --null "$2" "$1/" | \
        xargs -0 sed -i "s/$2/$3/g"
}

function delbranch {
    git branch -d "$1"
    git push origin ":$1"
}
