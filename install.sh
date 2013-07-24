# Install Modules
#if [ `uname` = "Darwin" ]; then
#    brew install bash-completion


# Installing Process
if [ `uname` = "Linux" ]; then
    # Ctags 5.8
    mkdir -p $HOME/local/bin
    mkdir -p $HOME/local/src
    cd $HOME/local/src/

    wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
    tar zxf ctags-5.8.tar.gz
    cd ctags-5.8
    ./configure --prefix=$HOME/local
    sudo make install
fi


# Create symbolic links
FILES=(.bashrc .vim .vimrc .tmux.conf)

for file in ${FILES[@]}
do
    orgfile=$HOME/$file
    if [ -L ${orgfile} ]; then
        echo "Remove existing symbolic link"
        rm -v ${orgfile}
    elif [ -f ${orgfile} -o -d ${orgfile} ]; then
        echo "Backup original file"
        mv ${orgfile} ${orgfile}_`date +%Y%m%d`
    fi

    echo "Create symbolic link: $HOME/$file"
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# Install neobundle.vim
if [ -d ~/.vim/bundle ]; then
    rm -rf ~/.vim/bundle
fi
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim -c 'NeoBundleInstall!' -c quit

# Change Git Settings
cd ~/dotfiles
git config user.name aeroastro
git config user.email aeroastro
git config color.ui auto
