# markl oh-my-zsh theme

function precmd() {
    "$DF_VENV/bin/pieprompt" top "$(tput cols)"
}

PROMPT='%5{$("$DF_VENV/bin/pieprompt" bottom "$(tput cols)")%}'
RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

