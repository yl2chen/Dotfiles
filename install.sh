#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Vim
ln -s .vimrc ~/.vimrc

# Scm breeze
ln -s ~/dotfiles/.scm_breeze ~/.scm_breeze
~/.scm_breeze/install.sh
