#[ Start Graphical Session with UWSM ]
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

# -- Launch TMUX
if [[ -z "$TMUX" ]] && command -v tmux >/dev/null; then
  tmux attach -t 0LA-X || tmux new -s 0LA-X
fi

# if [[ -o interactive ]]; then
# fi

  # if command -v wayclick >/dev/null; then
  #   uwsm-app -- "$HOME/.local/bin/wayclick"
  # fi
    
# # #[ Wayvibes ]
# if command -v wayvibes >/dev/null 2>&1; then
#   if ! pgrep -x "wayvibes" >/dev/null; then
#     wayvibes --device > /dev/null 2>&1 \ 
#     wayvibes ~/.config/key-sounds/akko_lavender_purples -v 6 --background
#   fi
# fi
