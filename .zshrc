# .zshrc

# {{{ Init
# -------------------------------------------------------------------------------
autoload -U compinit && compinit
unsetopt beep
bindkey -e # emacs keybindings
# }}}
# {{{ Exports
# -------------------------------------------------------------------------------
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export EDITOR=vim
export TERMINAL=urxvtc
export BROWSER=firefox
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# }}}
# {{{ Prompt
# -------------------------------------------------------------------------------
autoload -U colors && colors
prompt off # Disable the prompt engine so we can set our own
PS1="%{$fg[yellow]%}┌┤%{$fg_bold[yellow]%}%n%{$reset_color%}%{$fg[green]%}@%{$fg[red]%}%m%{$fg[yellow]%}(%{$fg[cyan]%}%l%{$fg[yellow]%})%{$fg_bold[blue]%}%~%{$fg[yellow]%}│%{$reset_color%}%*
%{$fg[yellow]%}└%{$fg_bold[blue]%}%?%{$reset_color%}%{$fg[yellow]%}┐%{$reset_color%}%# "
#}
# }}}
# {{{ Keybindings
# -------------------------------------------------------------------------------
bindkey "\e[1~"  beginning-of-line    # Home
bindkey "\e[4~"  end-of-line          # End
bindkey "\e[5~"  beginning-of-history # PageUp
bindkey "\e[6~"  end-of-history       # PageDown
bindkey "\e[2~"  quoted-insert        # Ins
bindkey "\e[3~"  delete-char          # Del
bindkey "\e[5C"  forward-word
bindkey "\eOc"   emacs-forward-word
bindkey "\e[5D"  backward-word
bindkey "\eOd"   emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z"   reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~"  beginning-of-line     # Home
bindkey "\e[8~"  end-of-line           # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH"   beginning-of-line
bindkey "\eOF"   end-of-line
# for freebsd console
bindkey "\e[H"   beginning-of-line
bindkey "\e[F"   end-of-line
# }}}

# Common
. $HOME/.shell_common
