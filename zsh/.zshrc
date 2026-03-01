#==========================# 
#  [ Session bootstrap ]               
#=========================#
# if [[ -o interactive ]]; then
    # -- Fun stuff 
  pokego -r 6,1,5,8,2,7 -no-title -s
  # pokego --name charmeleon --no-title # charizard - jigglypuff - eevee - - - 
  # fastfetch
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

 
#================#
  #[ Keybinds ]  
#================#
for map in emacs viins vicmd; do
  bindkey -M $map '^[[1~' beginning-of-line   # Home
  bindkey -M $map '^[[4~' end-of-line         # End
  bindkey -M $map '^[[3~' delete-char         # Delete

  bindkey -M $map '^H' backward-kill-word 
  bindkey -M $map '^Z' undo

  # bindkey -M $map '^[[A' history-substring-search-up
  # bindkey -M $map '^[[B' history-substring-search-down
done

# =====================================================
#   Completion system (before completion plugins)
# =====================================================
autoload -Uz compinit
compinit -C        # fast, safe if you trust your plugins
# _comp_options+=(globdots)

# =====================================================
#  Zinit bootstrap (must be early)
# =====================================================

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# -- Prompt (Starship)
# zinit ice as"command" from"gh-r" \
#   atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#   atpull"%atclone" src"init.zsh"
# zinit light starship/starship

# -- Prompt (powerlevel10k enable)
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ===========================================
# -- Plugins (lazy-loaded for speed) -- #
# ===========================================

# # -- Vi mode - wait'0' lucid
zinit ice depth=1 
zinit light jeffreytse/zsh-vi-mode

# Prevent starship <-> vi-mode recursion
zstyle ':zsh-vi-mode:*' prompt ''

# -- Autosuggestions & Fast syntax highlighting (heavy → lazy)
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#E3E4FA"

zinit light zdharma-continuum/fast-syntax-highlighting

# -- Completion extensions
zinit light zsh-users/zsh-completions

# -- Tools (lazy)
zinit snippet OMZL::completion.zsh  
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::history.zsh

zinit snippet OMZP::fzf
zinit snippet OMZP::zoxide
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found

zinit ice wait'0' lucid
zinit light zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red'

# After all zinit plugins
zinit cdreplay -q


# =====================================================
#  History behavior
# =====================================================
HISTSIZE=8000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="dd/mm/yyyy"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# =====================================================
#  Aliases
# =====================================================

# Navigation (zoxide)
# alias .='z ../'
# alias ..='z ../../'
# alias ...='z ../../../'
# alias ....='z ../../../../'

# Listing (eza)
alias c='clear'
alias x='exit'
alias l='eza -lh --icons=auto'
alias ls='eza -G --icons=auto'
alias lsa='eza -Ga --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Trash
alias tp='trash-put'

# Editor
alias vi='nvim'
alias vim='sudo nvim'
alias sudo-nvim='sudo env WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR HOME=/root nvim'
alias sudo-vi='sudo env WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR HOME=/root nvim'

# Git
alias ga='git add '
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gs='git status'
alias gss='git status -s'
alias gr='git restore'

# Wi-Fi
alias wifilist='nmcli device wifi list'
alias wifiscan='nmcli device wifi list --rescan yes'
alias wificonnect='nmcli device wifi connect --ask'

# System
alias pacman='sudo pacman'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
# alias gparted='sudo -E gparted'

# yt-dlp
alias yt-480='yt-dlp -f "bestvideo[height=480]+bestaudio/best[height=480]"'
alias yt-720='yt-dlp -f "bestvideo[height=720]+bestaudio/best[height=720]"'

# Session
alias exit-user='pkill -TERM -u $USER'
alias logout-user='pkill Hyprland || pkill tmux || loginctl terminate-user $USER'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
