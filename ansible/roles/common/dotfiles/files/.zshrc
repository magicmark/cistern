## ==============================================================================
## !! This file is managed by ansible !!
## https://github.com/magicmark/cistern
##
## Local changes will be overwritten!
##
## Try: ~/cistern/ansible/roles/common/dotfiles/files/.zshrc
## ==============================================================================

export PATH="${HOME}/bin:$PATH"
eval "$(starship init zsh)"
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"
export DOTFILES="$HOME/.config/dotfiles"

source "${DOTFILES}/.profile.zsh"
