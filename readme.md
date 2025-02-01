# Dotfiles
```sh
git clone https://github.com/shrimp332/dotfiles.git
git clone https://github.com/catppuccin/alacritty.git dotfiles/alacritty/alacritty/catppuccin
git clone https://github.com/shrimp332/nvim-config dotfiles/nvim/nvim
git clone https://github.com/zsh-users/zsh-autosuggestions dotfiles/zsh/zsh/plugins/zsh-autosuggestions
```
## Themes
```sh
# cursor
cd /tmp
wget https://github.com/ful1e5/banana-cursor/releases/download/v2.0.0/Banana.tar.xz
tar xf Banana.tar.xz
mkdir ~/.icons
mv Banana ~/.icons

# wallpaper
mkdir ~/Documents
wget https://w.wallhaven.cc/full/3l/wallhaven-3lp2md.jpg
mv wallhaven-3lp2md.jpg ~/Documents/wallpaper.jpg

# emoji picker, depends on wtype
git clone https://github.com/Zeioth/wofi-emoji.git /tmp/wofi-emoji
mv /tmp/wofi-emoji/wofi-emoji ~/.local/bin/wofi-emoji
chmod +x ~/.local/bin/wofi-emoji

gsettings set org.gnome.desktop.wm.preferences button-layout ":"
cd
```

### Gtk theme
gtk theme:
https://www.pling.com/p/1681315
icons:
https://www.pling.com/s/Gnome/p/1166289/

```sh
ln -sf ~/.themes/Tokyonight-Dark/gtk-2.0 $HOME/.config/gtk-2.0
ln -sf ~/.themes/Tokyonight-Dark/gtk-3.0 $HOME/.config/gtk-3.0
ln -sf ~/.themes/Tokyonight-Dark/gtk-4.0 $HOME/.config/gtk-4.0
```
