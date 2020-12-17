# .bashrc

export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export EDITOR=vim
export TERMINAL=urxvtc
export BROWSER=firefox
export PS1='\[\033[0;33m\]┌┤\[\033[0m\033[1;33m\]\u\[\033[0;32m\]@\[\033[0;31m\]\h\[\033[0m\033[0;36m\]:\w\[\033[0m\033[0;33m\]│\[\033[0m\]\t\n\[\033[0;33m\]└\[\033[0m\033[1;34m\]`echo $?`\[\033[0;33m\]┐\[\033[0m\]$ '
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Common
. $HOME/.shell_common
