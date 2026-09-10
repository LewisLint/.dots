# Set up the prompt
#autoload -Uz promptinit
#promptinit
#prompt adam1

#setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
ZSH_THEME="gruvbox"
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

alias ls="ls -a --colo=auto"
alias ll="ls -la"
alias v="vi"
alias '^l'="clear"
alias '~'="cd ~"
alias 'vzsh'="v ~/.zshrc && source ~/.zshrc"
alias cp='cp -v'
alias mv='mv -v'
alias img='ristretto'
alias ig='ristretto *'

#cd() {
#    builtin cd $@
#    ls
#}
#bindkey -M viins 'jj' vicmd

bindkey -s '^L' 'clear && printf "\\e[3J"\n'
#bindkey -s '^A' 'sudo '
#Enable Vi Mode
bindkey -v

# Enable Zsh color support
autoload -U colors && colors


#PROMPT="%{$fg[cyan]%}%n%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%} %# "
# Fix backspace/delete refusing to clear old text in vi-insert mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
pfetch
echo -ne "\e[6 q"
# Map jj to escape to normal mode
bindkey -M viins 'jj' vi-cmd-mode


# my bullshit:
# Enable dynamic prompt updating
setopt prompt_subst

# Set the default starting state (Blue I)
# Force the cursor to be a vertical bar on startup
printf '\e[5 q'

# Reset cursor back to a bar whenever a new prompt line draws
_set_cursor_bar() {
    printf '\e[5 q'
}
autoload -Uz add-zsh-hook

add-zsh-hook precmd _set_cursor_bar
# Detect mode changes and swap the RPROMPT character/color


RPROMPT="%F{blue}I%f"


function zle-keymap-select() {
  case $KEYMAP in
    vicmd)      RPROMPT="%F{green}N%f" ;; # Green Normal mode
    viins|main) RPROMPT="%F{blue}I%f"  ;; # Blue Insert mode
    visual)     RPROMPT="%F{244}V%f"  ;; # Gray Visual mode
  esac
  zle reset-prompt
}
zle -N zle-keymap-select

# Ensure the prompt resets back to Insert mode for a clean new line
function zle-line-init() {
  RPROMPT="%F{blue}I%f"
  zle reset-prompt
}
zle -N zle-line-init
KEYTIMEOUT=15

bindkey -M vicmd '?' history-incremental-search-backward
#bindkey -v # Enables vim mode
alias ytdlp='yt-dlp -f "best[height<=720]" --impersonate chrome --cookies-from-browser chromium'
alias py="python"








alias clear="clear && pfetch"
# Enable prompt expansion so functions run inside the prompt
setopt PROMPT_SUBST

# Enable vim keybindings
bindkey -v

# Function to build the conditional arrow and exit code
build_arrow() {
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        # Success: Green arrow (Replace '❯' with any symbol you prefer)
        echo "%F{green}❯%f"
    else
        # Failure: Red exit code followed by a Red arrow
        echo "%F{red} $exit_code ❯%f"
    fi
}

# Construct the final prompt
PROMPT='%F{blue}%~%f $(build_arrow) '

# aliases:
alias ls='eza --icons'
alias ll='eza -lah --icons'
alias la='eza -a --icons'
