#!/bin/bash

# Function to source files if they exist
function zsh_add_file() {
    [ -f "$1" ] && source "$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo "$1" | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo "$1" | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
		completion_file_path=$(ls "$ZDOTDIR/plugins/$PLUGIN_NAME/_"*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls "$ZDOTDIR/plugins/$PLUGIN_NAME/_*")
		rm "$ZDOTDIR/.zccompdump"
    fi
	completion_file="$(basename "${completion_file_path}")"
	[ "$2" = true ] && compinit "${completion_file:1}"
}