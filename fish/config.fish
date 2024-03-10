export (envsubst < ~/.config/xdgenv)
export (envsubst < ~/.config/env)
function ya
	set tmp (mktemp -t "yazi-cwd.XXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting ''
    alias ls="eza -F" 
    alias la="eza -aF"
    alias ll="eza -laF --grid"
    alias lt="eza -laF --tree --level"
    alias cat="bat"
    alias df="df -TH"
    alias lg="lazygit"
    alias nv="nvim"
    alias reflector="reflector @/etc/xdg/reflector/reflector.conf"
    alias ecm="ecryptfs-mount-private"
    alias ecu="ecryptfs-umount-private"
    alias dev="distrobox enter devbox"
    alias debian="distrobox enter debianbox"
    alias gitstash="git stash"
    alias gitpop="git stash pop"
    alias gitcheck="git checkout"
    alias webcord="webcord --ozone-platform=wayland"
    starship init fish | source
    zoxide init fish --no-cmd | source
    alias z="__zoxide_z"
    alias zi="__zoxide_zi"
end
