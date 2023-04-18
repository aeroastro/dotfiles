if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# For Git Completion
source ~/dotfiles/repos/git/contrib/completion/git-prompt.sh
source ~/dotfiles/repos/git/contrib/completion/git-completion.bash

# plenv
export PATH="$HOME/.plenv/bin:$PATH";
eval "$(plenv init -)"

# pyenv & virtualenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export LC_ALL=ja_JP.UTF-8 # https://github.com/pypa/pipenv/issues/187#issuecomment-375172264
export LANG=ja_JP.UTF-8

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH";
eval "$(rbenv init -)"
source "$HOME/.rbenv/completions/rbenv.bash"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# go
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# mysql-build
export PATH="$HOME/mysql-build/bin:$PATH"

# Beautiful Display (have bugs we need fix this)
function length() { echo -n ${#1}; }
function current_columns() { echo $COLUMNS; }
CYAN="\e[0;36m\]"
YELLOW="\e[0;33m\]"
COLOR_RESET="\e[00m\]"
function print_pre_prompt() {
  local PS1L="[${USER}@${HOSTNAME}] ($(date "+%Y-%m-%d %H:%M:%S"))"
  local PS1L="[${USER}@${HOSTNAME} ${PWD##*/}] ($(date "+%Y-%m-%d %H:%M:%S"))"
  local PS1R=$PWD; if [[ $PS1R/ = "$HOME"/* ]]; then PS1R=\~${PS1R#$HOME}; fi

  local MARGIN=$(($COLUMNS - ${#PS1L} - 3));
  local ABBREV_PREFIX=...
  local READABLE_RIGHT_BLANK=10
  if [[ $MARGIN < $READABLE_RIGHT_BLANK ]]; then
    PS1R=
  elif [[ $MARGIN < $(( ${#PS1R} + ${#ABBREV_PREFIX} )) ]]; then
    # echo "MARGIN $MARGIN"
    # echo "ABBREV $ABBREV_PREFIX"
    # echo "PS1R   ${#PS1R}"
    PS1R="${ABBREV_PREFIX}${PS1R:$((${#PS1R} - $MARGIN + ${#ABBREV_PREFIX})):$(($MARGIN - ${#ABBREV_PREFIX}))}"
    # echo 'hello'
  fi
  # PS1R=${YELLOW}${PS1R}${COLOR_RESET}
  local PS1_COL1=$(printf "%s%$(($COLUMNS+${#YELLOW}+${#COLOR_RESET}-${#PS1L}-1))s" "${CYAN}${PS1L}${COLOR_RESET}" "${YELLOW}${PS1R}${COLOR_RESET}")
  PS1="${PS1_COL1}\n$ "
}
PROMPT_COMMAND=print_pre_prompt


function git-grep-blame() {
    pattern=$1
    target=$2
    for match in `git grep -n $pattern $target | perl -pe 's/([^:]+):([^:]+).*/"$1:$2\n"/se'`;
    do
        file=`echo $match | cut -d ':' -f 1`
        line=`echo $match | cut -d ':' -f 2`
        blame=`git blame -L $line,$line $file`
        echo $file:$line:$blame
    done
}

function find-pr() {
    local parent=$2 || 'master'
    git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

# Google Cloud SDK

# The next line updates PATH for the Google Cloud SDK.
source ~/google-cloud-sdk/path.bash.inc

# The next line enables shell command completion for gcloud.
source ~/google-cloud-sdk/completion.bash.inc

[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export CPPFLAGS="-I/usr/local/opt/openjdk/include"
source "$HOME/.cargo/env"

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

export DOTNET_CLI_TELEMETRY_OPTOUT=true
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"


# dotnet

# bash parameter completion for the dotnet CLI

function _dotnet_bash_complete()
{
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet
