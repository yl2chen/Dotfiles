#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
exe() { "$@" ; [ $? == 0 ] && ret="\x1B[47m OKAY" || ret="\x1B[41m FAIL"; echo -e "$ret \x1B[0m \$ $@" ; }

header() { printf "\n==========$@========================================\n\n"; }

link_file() {
  if [ -h $HOME/$@ ] || [ -f $HOME/$@ ]; then
    exe mv $HOME/$@ $BACKUP_FOLDER/$@
  fi
  exe ln -s $BASE_PATH/$@ $HOME/$@
}

# Make backup folder
BACKUP_FOLDER="$HOME/.dotfiles_backup"
if [ -d "$BACKUP_FOLDER" ]; then
  echo -e "\x1B[41m FAIL \x1B[0m Directory $BACKUP_FOLDER exists already, back it up and remove, then run install script again."
  exit 1
fi
mkdir $BACKUP_FOLDER

# bash_profile
header "bash profile"
link_file ".bash_profile"

# Link vimrc
header "vim"]
link_file ".vimrc"

# Scm breeze
header "scm_breeze"
if [ -d $HOME/.scm_breeze ]; then
  exe $HOME/.scm_breeze/uninstall.sh
  exe mv $HOME/.scm_breeze $BACKUP_FOLDER
fi

if [ -h $HOME/.scm_breeze ]; then
  echo "scm_breeze already installed, skipping."
else
  exe ln -s $BASE_PATH/scm_breeze $HOME/.scm_breeze
  $HOME/.scm_breeze/install.sh
fi

# Fonts
# fonts/install.sh

header "source profile"
exe source $HOME/.bash_profile

header "notes"
printf "\nRESTART SHELL\n"
