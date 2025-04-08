#!/bin/bash

# use stow to create symlink 
stow -t ~/.config/nvim -d ~/configs -S nvim
stow -t ~/.config/fish -d ~/configs -S fish 
