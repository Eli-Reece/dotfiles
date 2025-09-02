# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#                           

# -----------------------------------------------------
# Theme
# -----------------------------------------------------
ZSH_THEME="powerlevel10k/powerlevel10k"

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
export EDITOR=nvim
export PATH="/usr/lib/ccache/bin/:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias cl='clear'
alias cd..='cd ..'
alias eligrep='grep -nRHi'
alias pa='yay -Ss'
alias ff='fastfetch'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

# -----------------------------------------------------
# Editor
# -----------------------------------------------------
alias m='$EDITOR'
alias ra='source ranger'
alias ws='find . \( -name "*.c" -o -name ".h" -o -name "Makefile" -o -name "*.rs" -o -name "*.md" \) -exec sed -i "s/[[:space:]]\+$//" {} +'
alias ais='aichat -s'

# -----------------------------------------------------
# Configs
# -----------------------------------------------------
alias zshrc='m ~/.zshrc'
alias reload='source ~/.zshrc'
alias initvim='m ~/.config/nvim/init.vim'
alias iv='initvim'
alias swayconf='m ~/.config/sway/config'
alias sc='swayconf'
alias tmuxconf='m ~/.tmux.conf'

# -----------------------------------------------------
# Tmux
# -----------------------------------------------------
alias tls='tmux list-sessions'
alias ta='tmux attach -t'

# -----------------------------------------------------
# Settings
# -----------------------------------------------------
alias wifi='nmtui'

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias up='sudo pacman -Sy archlinux-keyring && sudo pacman -Syu'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias stor='du -sh * | sort -h'

# -----------------------------------------------------
# Music
# -----------------------------------------------------
alias ytdl="yt-dlp -x --audio-format opus -o '%(title)s.%(ext)s'"

# -----------------------------------------------------
# Functions
# -----------------------------------------------------
bbb_set() {
	export PATH=~/x-tools/arm-cortex_a8-linux-gnueabihf/bin:$PATH
    export CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf-
    export CC=arm-cortex_a8-linux-gnueabihf-
    export ARCH=arm
    echo "BBB cross-compile environment activated"
}

bbb_unset() {
    PATH=$(echo $PATH | sed 's|~/x-tools/arm-cortex_a8-linux-gnueabi/bin:||')
    unset CROSS_COMPILE
    unset CC
    unset ARCH
}

# -----------------------------------------------------
# oh-myzsh 
# -----------------------------------------------------
plugins=(
    git
    sudo
    web-search
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

# Set-up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
# -----------------------------------------------------
source <(fzf --zsh)

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# -----------------------------------------------------
# AUTOSTART
# -----------------------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
