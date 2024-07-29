#!/bin/sh

sourcedir="$ZDOTDIR/source"

plugins=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "romkatv/powerlevel10k"
    "zsh-users/zsh-history-substring-search"
    "MichaelAquilina/zsh-auto-notify"
    "MichaelAquilina/zsh-you-should-use"
    # "chrissicool/zsh-256color"
)
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

completions=(
    "esc/conda-zsh-completion"
)

# -----------------------------------------------------------------------------

# Useful Functions
source "$sourcedir/functions"

# Normal files to source
for f in $sourcedir/*;
do
    zsh_add_file $f
done

# Plugins
for plugin in $plugins;
do
    zsh_add_plugin $plugin
done

# Completions
for completion in $completions;
do
    zsh_add_completion $completion false
done

### Powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# Jump
source `jump-bin --zsh-integration`

# Source personal config for all terminals
if [ -f "$HOME/.config/terminal/config" ]; then
    zsh_add_file "$HOME/.config/terminal/config"
fi

# history substring
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
