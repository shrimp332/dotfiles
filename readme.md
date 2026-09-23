# Dotfiles
```sh
git clone https://github.com/shrimp332/dotfiles.git
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

gsettings set org.gnome.desktop.wm.preferences button-layout ":"
cd
```
