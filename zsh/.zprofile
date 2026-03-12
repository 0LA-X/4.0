# if [[ -o interactive ]]; then
#   # -- Launch TMUX
#   if [[ -z "$TMUX" ]] && command -v tmux >/dev/null; then
#     tmux attach -t 0LA-X || tmux new -s 0LA-X
#   fi
# fi


#
#[ Start Graphical Session with UWSM ]
# if uwsm check may-start; then
#   exec uwsm start hyprland.desktop
# fi
