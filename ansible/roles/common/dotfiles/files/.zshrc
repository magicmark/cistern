# Path for dotfiles stuff
source "$HOME/.config/dotfiles/.paths"

# Set up oh-my-zsh
export ZSH="$HOME/GitApps/oh-my-zsh"
ZSH_THEME="markl"
plugins=(git tmux vundle virtualenv zsh_reload)
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/games"
export PATH="$PATH:./node_modules/.bin"
export PATH="$HOME/.poetry/bin:$PATH"
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

krp() {
    local pids_to_kill=$(sudo acquire-local-subnet list-all | grep $(yelp-main-acceptance-pgname) | awk -F"[:/ ]+" '//{print $2}' | xargs -I{} lsof -t -i@"{}:9080")
    echo "!! Warning !!"
    echo "Killing the following processes:"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo "$pids_to_kill" | xargs -I{pid} bash -c 'ps aux | grep "{pid}" | grep -v grep'
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

    read "confirm?Continue? "
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
		echo "$pids_to_kill" | xargs -I{} kill {}
    else
        echo "Bailing!"
    fi
}
