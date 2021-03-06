# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/nev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=9999
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# STUFF

setopt menucomplete
setopt correctall
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
_comp_options+=(globdots)
zstyle ':completion:*' rehash true

# HISTORY

setopt extended_history
setopt share_history
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# VARIABLES

export PATH="$PATH:$HOME/dev/sh:$HOME/soft"
export VISUAL="vim"
export EDITOR="vim"
export TERM=xterm-256color

# COLORED OUTPUT

if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias irclog="grc --colour=auto irclog"
 alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias proftpd="grc --colour=auto proftpd"
 alias traceroute="grc --colour=auto traceroute"
fi

export GREP_COLORS="mt=33"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
    alias ls='ls --color -X'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

eval `dircolors ~/.dir_colors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;36m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# PROMPTS

# colors

autoload -U colors && colors

for color in red green yellow blue magenta cyan black white; do
    eval $color='%{$fg_no_bold[${color}]%}'
    eval ${color}_bold='%{$fg_bold[${color}]%}'
done

reset="%{$reset_color%}"

# host (for ssh)

if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
  host="${blue}%m " #SSH
else
  unset host # no SSH
fi

if [ "$EUID" -eq 0 ]; then
    export PROMPT="${host}${red_bold}  [%n${white}:${cyan}%d]${reset} >"
else
    export PROMPT="${host}${green_bold}%n${white}:${cyan}%d${white}> ${reset}"
fi

unset RPROMPT

SPROMPT="Did you mean ${green}%r${reset} instead of ${red_bold}%R${reset}? "

# KEY BINDINGS

autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

bindkey '^[[1;5D'   backward-word
bindkey '^[[1;5C'   forward-word
bindkey '^[[3;5~'   kill-word

zmodload zsh/complist
bindkey -M menuselect "^M" .accept-line
bindkey -M menuselect "/" accept-and-infer-next-history
bindkey -M menuselect "^[" send-break 

# ALIASES

alias -s pdf=okular
alias -s {avi, mkv, mp4, mp3}=vlc
alias vi='vim'
alias df='df -h'
alias pacman='sudo pacman'
alias yaourt-clean='yaourt -Rns $(pacman -Qtdq)'
alias yaourt-list='yaourt -Qet'

alias cat='vimcat'

# FUNCTIONS

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  tar xvfJ $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

zmodload zsh/zpty

pty() {
	zpty pty-${UID} ${1+$@}
	if [[ ! -t 1 ]];then
		setopt local_traps
		trap '' INT
	fi
	zpty -r pty-${UID}
	zpty -d pty-${UID}
}

ptyless() {
	pty $@ | less
}
