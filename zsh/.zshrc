# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -U compinit; compinit

# Util funcs
_have() { type "$1" &>/dev/null }
_have_file() { test -e "$1" &>/dev/null }
_alif() { _have "$2" && alias "$1"="$2 $3" }

# ENV
_have envsubst && \
  export $(envsubst < ~/.config/xdgenv) && \
  export $(envsubst < ~/.config/env)

if [[ -o interactive ]]; then
    # Vim
    _alif vi vim && export EDITOR=vim
    _alif vi nvim && export EDITOR=nvim && export MANPAGER='nvim +Man!'


    # Aliases
    _alif ls eza "-F --color=auto"
    _alif la eza "-aF --color=auto"
    _alif ll eza "-laF --color=auto"
    _alif cat bat
    alias df="df -TH"
    _alif lg lazygit
    _alif ecm ecryptfs-mount-private
    _alif ecu ecryptfs-umount-private
    _alif rm trash

    # Keybinds
    bindkey -s "^[s" "^asudo ^e"

    # Plugins
    ZSH_PLUGIN_DIR=~/.config/zsh/plugins/
    _have_file $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh && \
      source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

    # Enable delete key
    bindkey "^[[3~" delete-char

    # Yazi
    _have yazi && \
    function ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }

    _have fzf && \
      source <(fzf --zsh)
    # Zoxide
    _have zoxide && \
      eval "$(zoxide init zsh)"
    _alif z __zoxide_z
    _alif zi __zoxide_zi
    # Starship
    _have starship && \
      eval "$(starship init zsh)"
    _have nerdfetch && \
      nerdfetch
fi
