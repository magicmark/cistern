# Notes

## Python

### 1. Homebrew

From https://brew.sh/

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 2. pyenv

From https://github.com/pyenv/pyenv

```
brew install pyenv
```

activate python3.x:

```
pyenv install 3.9.1
pyenv global 3.9.1
```

### 3. Poetry

https://python-poetry.org/docs/

```
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
```

## Changing the hostname

https://apple.stackexchange.com/a/86545

## macos install issues

https://github.com/pyca/cryptography/issues/3489#issuecomment-312607156

```
brew upgrade openssl


export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
```

## rpi install

https://cryptography.io/en/latest/installation/#debian-ubuntu

install:
- git
- virtualenv

## .zshrc

```bash
export APOLLO_TELEMETRY_DISABLED=1
export PATH="/opt/homebrew/bin:$PATH"
eval "$(starship init zsh)"
alias devbox="ssh-A markl@devbox"
alias gst="git status"
alias gc="git commit -m"
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
```
