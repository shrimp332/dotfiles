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
    alias ls="eza" 
    alias la="eza -a"
    alias ll="eza -la --grid"
    alias lt="eza -la --tree --level"
    alias cat="bat"
    alias df="df -TH"
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
end
