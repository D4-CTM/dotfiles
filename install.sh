#!/bin/bash

function createSymLink {
	if [[ -L "$2" ]]; then
		echo "$2 is already a symlink"
		return
	fi

	if [[ -e "$2" ]]; then
		echo "$2 already exists."
		read -p "Do you want to replace it? [y/N] " yn
		case $yn in
			[yY] )
				echo "Backing up $2"
				mv "$2" "$2-bak"
			;;
			* ) return ;;
		esac

	fi

	echo "Creating symlink: $1 <- $2"
	ln -s "$1" "$2"
}



case $1 in
	"hypr" )
		echo "Creating symlinks for $1"	
		createSymLink $HOME/dotfiles/wm/hypr/ ~/.config/hypr
		createSymLink $HOME/dotfiles/wm/waybar/ ~/.config/waybar
	;;
	
	"sway" )
		echo "Creating symlinks for $1"	
		createSymLink $HOME/dotfiles/wm/sway/ ~/.config/sway
		createSymLink $HOME/dotfiles/wm/waybar/ ~/.config/waybar
	;;

	"river" )
		echo "Creating symlinks for $1"	
		createSymLink $HOME/dotfiles/wm/river/ ~/.config/river
		createSymLink $HOME/dotfiles/wm/yambar/ ~/.config/yambar
	;;
esac

createSymLink $HOME/dotfiles/nvim/ ~/.config/nvim
createSymLink $HOME/dotfiles/kitty/ ~/.config/kitty
createSymLink $HOME/dotfiles/tmux.conf ~/.tmux.conf

createSymLink $HOME/dotfiles/starship.toml ~/.config/starship.toml
