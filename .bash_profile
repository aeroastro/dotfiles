if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# plenv
export PATH="$HOME/.plenv/bin:$PATH";
eval "$(plenv init -)"

# pyenv & virtualenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH";
eval "$(rbenv init -)"
source "$HOME/.rbenv/completions/rbenv.bash"

# ndenv
export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"

# go
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# mysql-build
export PATH="$HOME/mysql-build/bin:$PATH"
