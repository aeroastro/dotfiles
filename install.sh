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
PYENV_ROOT=~/.pyenv
if [ -d $PYENV_ROOT ]; then
  (cd $PYENV_ROOT && git pull)
else
  git clone https://github.com/pyenv/pyenv $PYENV_ROOT
fi

echo "Installing virtualenv https://github.com/pyenv/pyenv-virtualenv"
VIRTUAL_ENV_ROOT=$PYENV_ROOT/plugins/pyenv-virtualenv
if [ -d $VIRTUAL_ENV_ROOT ]; then
  (cd $VIRTUAL_ENV_ROOT && git pull)
else
  git clone https://github.com/pyenv/pyenv-virtualenv.git $VIRTUAL_ENV_ROOT
fi

echo "Installing rbenv and ruby build"
RBENV_ROOT=~/.rbenv
if [ -d $RBENV_ROOT ]; then
  (cd $RBENV_ROOT && git pull)
else
  git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
fi
RUBY_BUILD_ROOT=$RBENV_ROOT/plugins/ruby-build
if [ -d $RUBY_BUILD_ROOT ]; then
  (cd $RUBY_BUILD_ROOT && git pull)
else
  git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_ROOT
fi

echo "Installing plenv"
PLENV_ROOT=~/.plenv
if [ -d $PLENV_ROOT ]; then
  (cd $PLENV_ROOT && git pull)
else
  git clone https://github.com/tokuhirom/plenv.git $PLENV_ROOT
fi
PERL_BUILD_HOME=$PLENV_ROOT/.plenv/plugins/perl-build
if [ -d $PERL_BUILD_HOME ]; then
  (cd $PERL_BUILD_HOME && git pull)
else
  git clone https://github.com/tokuhirom/Perl-Build.git $PERL_BUILD_HOME
fi

echo "Installing Android Studio (Not Implemented now)"

echo "Install git completions"
if [ ! -d ~/dotfiles/repos/git ]; then
  git clone --depth=1 https://github.com/git/git.git ~/dotfiles/repos/git
fi

# Show Messages
echo "Install Completed";
