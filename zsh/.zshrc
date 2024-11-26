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
    alias ls="eza -F --color=auto" 
    alias la="eza -aF --color=auto"
    alias ll="eza -laF --color=auto"
    alias cat="bat"
    alias df="df -TH"
    alias lg="lazygit"
    alias vi="nvim"
    alias ecm="ecryptfs-mount-private"
    alias ecu="ecryptfs-umount-private"
    alias rm=trash

    # Temp fix
    #alias imv="env -u WAYLAND_DISPLAY imv-dir"

    # Keybinds
    bindkey -s "^[s" "^asudo ^e"

    # Plugins
    ZSH_PLUGIN_DIR=~/.config/zsh/plugins/
    source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

    # Enable delete key
    bindkey "^[[3~" delete-char

    # Yazi
    function ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }

    source <(fzf --zsh)
    # Zoxide
    eval "$(zoxide init zsh)"
    alias z="__zoxide_z"
    alias zi="__zoxide_zi"
    # Starship
    eval "$(starship init zsh)"
    nerdfetch
fi
