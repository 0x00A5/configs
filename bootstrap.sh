#!/bin/bash

# Bootstrap script for `devcontrainer up`

# install packages

# use stow to create symlink
cd ~/dotfiles || exit
stow -t ~ shell
stow -t ~ editor
