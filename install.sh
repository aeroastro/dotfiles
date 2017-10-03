#!/bin/bash
set -eu

OS=`uname -s`

# install Brewfile

if [ "$OS" = "Darwin" ]; then
  if ! which brew; then
    echo "Installing Homebrew https://brew.sh/"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Updating Homebrew"
  brew analytics off # Maybe we can on this.
  brew update
  brew bundle
fi

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
PERL_BUILD_ROOT=$PLENV_ROOT/plugins/perl-build
if [ -d $PERL_BUILD_ROOT ]; then
  (cd $PERL_BUILD_ROOT && git pull)
else
  git clone https://github.com/tokuhirom/Perl-Build.git $PERL_BUILD_ROOT
fi

echo "Installing ndenv and node build"
NDENV_ROOT=~/.ndenv
if [ -d $NDENV_ROOT ]; then
  (cd $NDENV_ROOT && git pull)
else
  git clone https://github.com/riywo/ndenv $NDENV_ROOT
fi
NODE_BUILD_ROOT=$NDENV_ROOT/plugins/node-build
if [ -d $NODE_BUILD_ROOT ]; then
  (cd $NODE_BUILD_ROOT && git pull)
else
  git clone https://github.com/riywo/node-build.git $NODE_BUILD_ROOT
fi

echo "Installing Android Studio (Not Implemented now)"

echo "Installing relevant repositories"
GIT_ROOT=~/dotfiles/repos/
echo "Install git completions"
GIT_COMPLETION_ROOT=$GIT_ROOT/git
if [ -d $GIT_COMPLETION_ROOT ]; then
  (cd $GIT_COMPLETION_ROOT && git pull)
else
  git clone --depth=1 https://github.com/git/git.git $GIT_COMPLETION_ROOT
fi

# Show Messages
echo "Install Completed";
