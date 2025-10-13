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
		echo "Creating symlinks for hyprland"	
		createSymLink $HOME/dotfiles/hypr/ ~/.config/hypr
		createSymLink $HOME/dotfiles/waybar/ ~/.config/waybar
		createSymLink $HOME/dotfiles/wofi/ ~/.config/wofi
	;;
	"gnome" )
		echo "Creating simlinks for gnome"
		createSymLink $HOME/dotfiles/ulauncher/ ~/.config/ulauncher
	;;
esac

createSymLink $HOME/dotfiles/nvim/ ~/.config/nvim
createSymLink $HOME/dotfiles/kitty/ ~/.config/kitty

createSymLink $HOME/dotfiles/starship.toml ~/.config/starship.toml
