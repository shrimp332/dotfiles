HISTFILE=~/.config/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS
setopt autocd nomatch
unsetopt beep extendedglob notify
bindkey -e

fpath=(~/.local/share/zsh/completions $fpath)

# Util funcs
_have() { type "$1" &>/dev/null }
_have_file() { test -e "$1" &>/dev/null }
_alif() { _have "$2" && alias "$1"="$2 $3" }

# cmdlets
mkdircd() {mkdir "$1" && cd "$1"}

# ENV
if _have envsubst; then
    set -a
    source <(envsubst < ~/.config/xdgenv)
    source <(envsubst < ~/.config/env)
    set +a
fi

if [[ -o interactive ]]; then
    autoload -U compinit; compinit

    PS1='%B%F{white}%n:%F{blue}%~%f %(?.%F{white}❯%f.%F{red}❯%f) %b'

    # Vim
    _alif vi vim && export EDITOR=vim
    _alif vi nvim && export EDITOR=nvim && export MANPAGER='nvim +Man!'

    # Aliases
    alias ls="ls -F"
    alias la="ls -aF"
    alias ll="ls -laF"
    _alif ls eza "-F --color=auto"
    _alif la eza "-aF --color=auto"
    _alif ll eza "-laF --color=auto"
    _alif cat bat
    alias df="df -TH"
    _alif ecm gocryptfs "~/.Private ~/Private"
    _alif _ufusermount fusermount3 -u
    _alif ecu _ufusermount "~/Private"
    _alif rm trash
    _alif imv imv-dir
    _alif lg lazygit

    if _have xdg-open; then
        open() {
           (nohup xdg-open "$@" &> /dev/null &)
        }
    fi

    # Keybinds
    _have doas && bindkey -s "^[s" "^adoas !!^e"
    _have sudo && bindkey -s "^[s" "^asudo !!^e"
    bindkey "^[[3~" delete-char # delete key

    # Plugins
    ZSH_PLUGIN_DIR=~/.config/zsh/plugins/
    _have_file $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh && \
      source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh


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
    _have zoxide && \
      eval "$(zoxide init zsh)"
    _have starship && \
      eval "$(starship init zsh)"
    _have nerdfetch && \
      nerdfetch
fi
