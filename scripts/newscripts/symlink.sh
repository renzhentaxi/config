#!/bin/sh
currentDir=$(pwd)

mkdir -p ~/.config
cd ~/.config

echo "Symlinking config"

echo "nvim"
ln -sf $currentDir/nvim

echo "tmux"
ln -sf $currentDir/tmux.conf ~/.tmux.conf 
cd $currentDir  

echo "alacritty"
mkdir -p ~/.config/alacritty
ln -sf $currentDir/configs/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "done"
