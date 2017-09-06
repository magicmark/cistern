#!/usr/bin/zsh

if [ -n "$DEVBOX" ]; then
    function rvim {
        local filepath="scp://markl@$DEVBOX/~/pg/$1"
        nvim "$filepath"
    }
fi

function pvim {
    nvim $(echo $1 | sed 's/\./\//g').py
}
