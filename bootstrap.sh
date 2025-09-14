#!/bin/bash

# Bootstrap script for `devcontrainer up`

# install packages
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fish -c "omf install bobthefish"

# use stow to create symlink
mkdir ~/.config
cd ~/dotfiles
stow -t ~ shell
stow -t ~ editor
