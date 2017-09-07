# Load Global Definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# For Safety
alias rm='rm -i';
alias cp='cp -i';
alias mv='mv -i';
alias ls='ls -G';

# Fast
alias gp='git pull --prune'
alias gs='git status'
alias gco='git checkout'
alias gsu='git submodule update --init --recursive --force'
