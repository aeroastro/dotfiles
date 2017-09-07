#!/bin/bash
set -eu

# install Brewfile
echo "Installing Homebrew https://brew.sh/"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off
brew update
brew bundle

# Create symbolic links
FILES=(.vimrc .editorconfig .bashrc .bash_profile)

for file in ${FILES[@]}
do
  orgfile=$HOME/$file
  if [ -L ${orgfile} ]; then
    echo "  Remove existing symbolic link"
    rm -v ${orgfile}
  elif [ -f ${orgfile} -o -d ${orgfile} ]; then
    echo "  Backup original file"
    mv ${orgfile} ${orgfile}_`date +%Y%m%d`
  fi

  echo "  Create symbolic link: $HOME/$file"
  ln -s $HOME/dotfiles/$file $HOME/$file
done


echo "Installing dein.vim"
DEIN_PLUGIN_DIR=~/.vim/dein/repos/github.com/Shougo/dein.vim
if [ -d $DEIN_PLUGIN_DIR ]; then
  (cd $DEIN_PLUGIN_DIR && git pull)
else
  mkdir -p $DEIN_PLUGIN_DIR
  git clone https://github.com/Shougo/dein.vim.git $DEIN_PLUGIN_DIR
fi
bash -c "vim -c 'qall'" # Load .vimrc and trigger dein install

echo "Installing pyenv https://github.com/pyenv/pyenv"
echo "Installing virtualenv https://github.com/pyenv/pyenv-virtualenv"
PYENV_ROOT=~/.pyenv
if [ -d $PYENV_ROOT ]; then
  git clone https://github.com/pyenv/pyenv $PYENV_DIR
  git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_DIR/plugins/pyenv-virtualenv
fi

echo "Installing Android Studio (Not Implemented now)"

echo "Install git completions"
if [ ! -d ~/dotfiles/repos/git ]; then
  git clone https://github.com/git/git.git ~/dotfiles/repos/git
fi

# Show Messages
echo "Install Completed";
