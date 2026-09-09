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
