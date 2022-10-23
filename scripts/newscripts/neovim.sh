#!/bin/sh

currentDir=$(pwd)

if [ -d "$currentDir/nvim" ]; then
		
	mkdir -p ~/.config
	cd ~/.config
	
	echo "Symlinking config"
	ln -sf $currentDir/nvim
    
    # download patched font https://www.nerdfonts.com/font-downloads hack Nerd Font
	cd $currentDir  

else
	echo "Needs to be at the root of the repository"
fi

