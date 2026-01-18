# #[ Wayvibes ]
if command -v wayvibes >/dev/null 2>&1; then
  if ! pgrep -x "wayvibes" >/dev/null; then
    wayvibes --device > /dev/null 2>&1 \ 
    wayvibes ~/.config/key-sounds/akko_lavender_purples -v 6 --background
  fi
fi
