#!/bin/bash

alias ls='ls --color=auto'
alias ll='ls -lhar'
alias zsh-update-plugins="find ""$ZDOTDIR/plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias lgit="lazygit"

alias oil="nvim +StartOil"

function require_clean_work_tree() {
    # Update the index
    git update-index -q --ignore-submodules --refresh
    err=0

    # Disallow unstaged changes in the working tree
    if ! git diff-files --quiet --ignore-submodules --; then
        echo >&2 "err: you have unstaged changes."
        git diff-files --name-status -r --ignore-submodules -- >&2
        err=1
    fi

    # Disallow uncommitted changes in the index
    if ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
        echo >&2 "err: your index contains uncommitted changes."
        git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
        err=1
    fi

    if [ "$err" = 1 ]; then
        echo >&2 "Please commit or stash them."
        return 1
    fi
}

function sgit() {
    if ! require_clean_work_tree; then
        return 1
    fi
    git "$@"
}

function gsw() {
    sgit switch "$@"
}

alias gst='git status'

zsh_config_file="$ZDOTDIR/.zshrc"

alias zsh-config='nvim $zsh_config_file'
alias zsh-reload='source $zsh_config_file'

alias j="jump"

alias zz="z -"

function ChdirToScriptDir() {
    cd "$(dirname "$0")" || exit
}

function ldir() {
    find . -mindepth 1 -maxdepth 1 -type d \( ! -iname ".*" \) | sed 's|^\./||g'
}

alias gh='google-chrome --proxy-server="http://127.0.0.1:8080"'

function touch_with_mkdir() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}

alias touch="touch_with_mkdir"

alias fzfd="find . -type d -print | fzf"
alias zf="cd \$(fzfd)"

if ! which bat > /dev/null; then
    alias bat="batcat"
fi

alias fzfp="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""

function ocrpdf() {
    python3 -m ocrmypdf --force-ocr -l eng+rus "$1" "$1"
}

function getext() {
    echo "${1##*.}"
}

function getfilename() {
    echo "${1%.*}"
}

function webptopng() {
    dwebp "$1" -o "$(getfilename "$1").png"
}

function convertext() {
    magick "$1" "$(getfilename "$1").#2"
}

function randfile() {
    find "$1" | shuf -n 1 | tr -d "\n"
}

function copy_image() {
    xclip -selection clipboard -target image/png -i < "$1"
}

function archi() {
    yay -Sy --noconfirm "$@"
}

function debian_install() {
    sudo apt install -y "$@"
}

function sysi() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    fi
    if [ "$OS" = "Arch Linux" ]; then
        archi "$@"
    elif [ "$OS" = "Ubuntu" ]; then
        debian_install "$@"
    else
        echo "Not supported for your OS"
    fi
}

function py_check_module() {
    python3 -c "import $1" 2> /dev/null || return 1
    return 0
}

function pyi() {
    module=$1
    pymodule=$2

    if [ -z "$pymodule" ]; then
        pymodule=$module
    fi

    if py_check_module "$pymodule"; then
        echo "$module is already installed"
        return 0
    fi

    sudo pacman -Sy --noconfirm "python-$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pacman"
        return 0
    fi

    pipx install --include-deps "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pipx"
        return 0
    fi

    pip install --user "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pip"
        return 0
    fi

    # https://stackoverflow.com/questions/76499565/python-does-not-find-module-installed-with-pipx
    pip install --user --break-system-packages "$module"
    # "$HOME/.venvs/MyEnv/bin/python" -m pip install --user "$module"

    if py_check_module "$pymodule"; then
        echo "$module installed with pip --break-system-packages"
        return 0
    else
        echo "$module not installed"
        return 1
    fi
}

function clip-in() {
    xclip -selection clipboard
}
function clip-out() {
    xclip -selection clipboard -o
}
