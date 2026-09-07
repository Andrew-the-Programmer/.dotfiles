#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

zmx_attach_command=$(zp-select)

if [ -z "$zmx_attach_command" ]; then
  exit 1
fi

current_window="$KITTY_WINDOW_ID"

other_window=$(kitten @ ls | jq -r --arg curr "$current_window" '
    .[0].tabs[].windows[] | select(.id != ($curr | tonumber)) | .id
' | head -1)

if [ -n "$other_window" ]; then
  kitten @ close-window --match "id:$other_window"
fi

eval "$zmx_attach_command"
