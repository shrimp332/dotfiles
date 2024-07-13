# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

# ENV
export $(envsubst < ~/.config/xdgenv)
export $(envsubst < ~/.config/env)

if [[ -o interactive ]]; then
    # Aliases
    alias ls="eza -F" 
    alias la="eza -aF"
    alias ll="eza -laF --grid"
    alias lt="eza -laF --tree --level"
    alias cat="bat"
    alias df="df -TH"
    alias lg="lazygit"
    alias nv="nvim"
    alias ecm="ecryptfs-mount-private"
    alias ecu="ecryptfs-umount-private"
    alias code="code --profile luke"

    # Temp fix
    alias imv="env -u WAYLAND_DISPLAY imv-dir"

    # Keybinds
    bindkey -s "^[s" "^asudo ^e"

    # Plugins
    ZSH_PLUGIN_DIR=~/.config/zsh/plugins/
    source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    #source $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

    # Enable delete key
    bindkey "^[[3~" delete-char

    # Yazi
    function ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }

    # Zoxide
    eval "$(zoxide init zsh)"
    alias z="__zoxide_z"
    alias zi="__zoxide_zi"
    # Starship
    eval "$(starship init zsh)"
fi
