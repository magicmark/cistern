# Path for dotfiles stuff
source "$HOME/.config/dotfiles/.paths"

# Set up oh-my-zsh
export ZSH="$HOME/GitApps/oh-my-zsh"
ZSH_THEME="markl"
plugins=(git tmux vundle virtualenv zsh_reload)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/games"
source "$ZSH/oh-my-zsh.sh"
export LC_ALL="en_US.UTF-8"

# Set up my dotfiles
source "$DOTFILES/.profile.zsh"

if [[ `uname` == 'Darwin' ]]; then
    export IS_OSX=1
    source $DOTFILES/.zshrc.osx
elif [[ `uname` == 'Linux' ]]; then
    export IS_LINUX=1
    source $DOTFILES/.zshrc.linux
fi

if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -e ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi
