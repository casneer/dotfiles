HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt extended_history
setopt inc_append_history
setopt share_history
setopt no_flow_control

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg/,/usr/local/,/usr}/sbin(N-/))
export PATH=$PATH:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin
export LANG=ja_JP.UTF-8
setopt auto_cd
setopt auto_pushd
setopt correct
setopt hist_save_no_dups
setopt no_beep
setopt magic_equal_subst
setopt long_list_jobs

alias ls="ls -G"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"

export GREP_OPTIONS
GREP_OPTIONS="--color=auto --binary-files=without-match --directories=recurse"

autoload -Uz colors
colors
autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' completer _complete _oldlist _prefix
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'


export LSCOLORS=gxfxcxdxbxegedabagacad
case ${UID} in
0)
  PROMPT="%B%{${fg[green]}%}${USER}->#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[green]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[green]}%}[${USER}@${HOST%%.*]%]} # "
  ;;
*)
  PROMPT="%{${fg[green]}%}${USER}->%%%{${reset_color}%} "
  PROMPT2="%{${fg[green]}%}%_->%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[green]}%}[${USER}@${HOST%%.*}] %%%{${reset_color}%} "
  ;;
esac
RPROMPT="[%{${fg[white]}%}%~%{${reset_color}%}]"

if type lv > /dev/null 2>&1 ; then
	export PAGER="lv"
	export LV="-c -l"
fi

export EDITOR=vim
if ! type vim > /dev/null 2>&1 ; then
	alias vim=vi
fi

email_files=(~/.email(N-.))
for email_file in ${email_files}; do
	export EMAIL=$(cat "$email_file")
	break
done

function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  lynx http://www.google.co.jp/$opt
}
