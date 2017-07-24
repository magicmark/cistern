# markl oh-my-zsh theme

# ====================
# PS1 parts
# ====================

function __git_info {
    local prompt_prefix="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
    local prompt_suffix="%{$fg[blue]%})%{$reset_color%}"
    local git_dir="$(git rev-parse --git-dir 2> /dev/null)"
    local dirty_char

    if [ -n "$git_dir" ]; then
        local branch_info

        if [ -d "$git_dir/../.dotest" ]; then
            branch_info="|AM/REBASE"
        elif [ -f "$git_dir/.dotest-merge/interactive" ]; then
            branch_info="|REBASE-i"
        elif [ -d "$git_dir/.dotest-merge" ]; then
            branch_info="|REBASE-m"
        elif [ -f "$git_dir/MERGE_HEAD" ]; then
            branch_info="|MERGING"
        elif [ -f "$git_dir/BISECT_LOG" ]; then
            branch_info="|BISECTING"
        fi

        # adapted from http://thepugautomatic.com/2008/12/git-dirty-prompt/
        if [[ ! "$(git status 2> /dev/null | tail -n1)" =~ "nothing to commit, working" ]]; then
            dirty_char=" %{$fg[yellow]%}✗%{$reset_color%}"
        fi

        echo " ${prompt_prefix}$(current_branch)${branch_info}${prompt_suffix}${dirty_char}"
    fi
}

function __virtualenv_info {
    if [ $VIRTUAL_ENV ]; then
        local venv="$(basename $VIRTUAL_ENV)"
        echo " %{$fg_bold[blue]%}virtualenv:(%{$reset_color%}%{$fg_bold[blue]%}%{$fg[red]%}${venv}%{$reset_color%}%{$fg_bold[blue]%})"
    fi
}

function __nodeenv_info {
    if [ $NODE_VIRTUAL_ENV ]; then
        local nenv="$(basename $NODE_VIRTUAL_ENV)"
        echo " %{$fg_bold[blue]%}nodeenv:(%{$reset_color%}%{$fg_bold[blue]%}%{$fg[red]%}${nenv}%{$reset_color%}%{$fg_bold[blue]%})"
    fi
}

function __u2253 {
    echo "%{$fg_bold[white]%}≓%{$reset_color%}"
}

function __prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $(__u2253); fi
}

# ====================
# Construct PS1
# ====================

function __get_ps1 {
    local curr_user="%{$fg_bold[blue]%}%n%{$reset_color%}"
    local curr_host="%{$fg_bold[green]%}%m%{$reset_color%}"
    local curr_dir="%{$fg_bold[cyan]%}%~%{$reset_color%}"
    local at_symbol="@"
    local top_brace="%{$FG[139]%}╔═%{$reset_color%}"
    local bottom_brace="%{$FG[139]%}╚═%{$reset_color%}"

    echo "
${top_brace} ${curr_user}${at_symbol}${curr_host}: ${curr_dir}$(__git_info)$(__virtualenv_info)$(__nodeenv_info)
${bottom_brace} $(__prompt_char) "
}


PROMPT='$(__get_ps1)'

ZLE_RPROMPT_INDENT=0
