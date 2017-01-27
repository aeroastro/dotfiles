#!/bin/bash
set -eu

# Install Modules
#if [ `uname` = "Darwin" ]; then
#    brew install bash-completion


# Installing Process
# if [ `uname` = "Linux" ]; then
#     # Ctags 5.8
#     mkdir -p $HOME/local/bin
#     mkdir -p $HOME/local/src
#     cd $HOME/local/src/
# 
#     wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
#     tar zxf ctags-5.8.tar.gz
#     cd ctags-5.8
#     ./configure --prefix=$HOME/local
#     sudo make install
# fi


# Create symbolic links
FILES=(.vimrc .editorconfig)

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
bash -c "vim --cmd 'dein#install()'"


# Show Messages
echo "Install Completed";
