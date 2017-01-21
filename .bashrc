# Load Global Definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# For Safety
alias rm='rm -i';
alias cp='cp -i';
alias mv='mv -i';
alias ls='ls -G';
