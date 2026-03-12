#!/usr/bin/env bash

set -euo pipefail


DOT_DIR="$HOME/4.0"
SCR_DIR="$HOME/4.0/Scripts/_helpers"
YAY_DIR="/tmp/yay"


PACMAN_PKGS=(
  # Utilities
  gcc gdb cmake meson 
  clang lld llvm ninja
  nodejs-lts-iron npm
  rustup lldb ripgrep
  git uwsm fd pv jq
  python python-pip python-uv 
  python-virtualenv uv  
  
  zoxide fzf nvim tmux
  stow rsync curl wget
  ncdu tldr duf impala
  man-db btop nvtop
  
  cifs-utils 7zip
  # cdrtools squashfs-tools
  unzip unrar unarchiver
  
  samba ufw chafa xdg-user-dirs
  fzf eza dysk fastfetch 
  trash-cli

  usbutils udisks2 udiskie
  imagemagick ffmpeg ffmpegthumbnailer
  brightnessctl ddcutil playerctl
  portmidi sdl2_image sdl2_mixer sdl2_ttf  

  kitty ghostty 

  #[ ]
  tuned-ppd cpupower cpu-x
  geoclue gammastep polkit-gnome

  # AMD Drivers
  amd-ucode vdpauinfo sof-firmware
  mesa mesa-utils libva-utils
  vulkan-radeon vulkan-icd-loader
  libvdpau-va-gl libva-mesa-driver

  #[ MISC] 
  yt-dlp mpv mpv-mpris 

  # Hyprland
  hyprland hypridle hyprlock
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk hyprpolkitagent

  #[ Explorer ]
  nautilus yazi

  # Fonts
  ttf-cascadia-code-nerd
  ttf-nerd-fonts-symbols
  noto-fonts-emoji
)

### --- AUR packages ---
AUR_PKGS=(
  bibata-cursor-theme-bin
  nautilus-share gvfs-mtp 
  nautilus-admin-gtk4
  nautilus-image-converter

  # Theming
  adw-gtk-theme nwg-look
  papirus-icon-theme
  pokego-git 
  file-roller bazarr breezy

  firefox obsidian terraria-server
  flaresolverr suwayomi-server-bin
  
  # zen-browser-bin 
)

SHELL=(
  caelestia-shell-git caelestia-cli-git
)



show_header() {
    cat << "EOF"

     ██╗ ██╗███╗   ██╗██╗  ██╗
     ██║███║████╗  ██║╚██╗██╔╝
     ██║╚██║██╔██╗ ██║ ╚███╔╝ 
██   ██║ ██║██║╚██╗██║ ██╔██╗ 
╚█████╔╝ ██║██║ ╚████║██╔╝ ██╗
 ╚════╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

EOF
}

if ! command -v pacman >/dev/null 2>&1; then
  echo "❌ pacman not found. This script is for Arch Linux only."
  exit 1
fi

sudo pacman -Sy --needed --noconfirm git base base-devel

install_yay(){
  echo "[ + ] Installing yay"
  sudo pacman -Sy --needed git base-devel
  git clone https://aur.archlinux.org/yay.git "$YAY_DIR"
  cd "$YAY_DIR"
  makepkg -si --noconfirm
  cd ~
  rm -rf "$YAY_DIR"
}

ensure_yay() {
  if ! command -v yay &> /dev/null; then
    echo "{ ! } yay not found. Installing..."
    install_yay
  else
    echo -e "{ - } yay is already installed.."
  fi
}

install_pkgs(){
  echo "▶ Installing pacman packages..."
  sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

  echo "▶ Installing AUR packages..."
  yay -S --needed --noconfirm "${AUR_PKGS[@]}"

  echo "▶ Installing CAELESTIA SHELL..."
  yay -S --needed --noconfirm "${SHELL[@]}"
  
  echo "✔ All packages installed successfully."
}

stow_dots(){
  if ! command -v stow &> /dev/null; then
    echo "{ + } Installing stow..."
    yay -S --noconfirm stow
  else
    echo "{ - } Stow already installed..."
  fi

  cd "$HOME"
  mkdir -p ./{.config/XX,.local/bin,.local/XY}
  
  echo "{ ! } Stowing dotfiles..."
  cd $DOT_DIR
  stow -v Config Local zsh 
}

helper_scripts(){
  echo "[ + ] Setting up TMUX & TPM"
  $SCR_DIR/tpm.sh
  
  echo "[ + ] Setting up ZSH"
  $SCR_DIR/setup_zsh.sh

  echo "[ + ] Setting up Audio & Bluetooth"
  $SCR_DIR/setup_audio.sh

  echo "[ + ] Setting up Boot-themes"
  $SCR_DIR/setup_boot_themes.sh
  
  # echo "[ + ] Setting up Keypad-Sounds (Wayvibes)"
  # $SCR_DIR/setup_keyboard.sh

  # echo "[ + ] Setting up PATCHES for Themes"
  # $SCR_DIR/setup_patches.sh
 
  # echo "[ + ] Setting up Spotify [spicetify]"
  # $SCR_DIR/spicetify.sh
}


MAIN(){
show_header
ensure_yay
install_pkgs
# stow_dots
helper_scripts
}


MAIN
