#!/bin/bash

alias ls='ls --color=auto'
alias ll='ls -lhar'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

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

	if [ $err = 1 ]; then
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

alias bat="batcat"
alias fzfp="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""
