#!/bin/sh
currentDir=$(pwd)

mkdir -p ~/.config
cd ~/.config

echo "Symlinking config"
ln -sf $currentDir/nvim

ln -sf $currentDir/tmux.conf ~/.tmux.conf 
cd $currentDir  


