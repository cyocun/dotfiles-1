## users generic .zshrc file for zsh(1)
#
# http://news.mynavi.jp/column/zsh/024/index.html
#

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac

## Set Default Editor
#
export EDITOR=emacs

## Set Emacs key binding
#
bindkey -e

## homebrew
#
export PATH=/usr/local/bin:$PATH

## tmuxinator
#
if [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] ; then source $HOME/.tmuxinator/scripts/tmuxinator ; fi

## anyenv
# http://qiita.com/luckypool/items/f1e756e9d3e9786ad9ea
#
if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in `find $HOME/.anyenv/envs -type d -d 1`
    do
        export PATH="$D/shims:$PATH"
    done
fi

## JavaVM
#
export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=$JAVA_HOME/bin:$PATH

## android-sdk
#
export ANDROID_SDK=/Applications/android-sdk-macosx
export ANDROID_SDK_HOME=$ANDROID_SDK
export PATH=$PATH:$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools

## Go
export GOPATH=$HOME/Documents/GOLIB
export PATH=$GOPATH/bin:$PATH

## Haskell
#
export PATH="$HOME/Library/Haskell/bin:$PATH"

## myscripts & depot_tools
#
export PATH=$PATH:$HOME/Dropbox/Toolkit/conf/scripts
export PATH=$PATH:$HOME/Dropbox/Toolkit/conf/depot_tools

## docker 1.6.2
#
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%~#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    PROMPT="%{${fg[red]}%}%~
%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd
setopt pushd_ignore_dups

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# report time varbose
#
REPORTTIME=3

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS     # ignore duplication command history list
setopt SHARE_HISTORY        # share command history data

## Directry history configuration
#
# http://shibayu36.hatenablog.com/entry/20120130/1327937835
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## anyframe for peco
# git clone git@github.com:mollifier/anyframe.git
#
fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
bindkey '^t' anyframe-widget-cdr
bindkey '^g' anyframe-widget-checkout-git-branch
bindkey '^r' anyframe-widget-execute-history
bindkey '^f' anyframe-widget-insert-filename

## Extract archives
#
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;  
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

## LESS
#
export LESS='-R'
export LESSOPEN='|lessfilter %s'

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias t='touch'
alias lisls='lsof -i | grep LISTEN'
alias ex='extract'
alias where="command -v"
alias rmdot="find . -name '.DS_Store' -print -exec rm -r {} ';' ; find . -name ._* -e"
alias trygz=trygz
alias c='pygmentize -O style=monokai -f console256 -g'
alias la="ls -a"
alias lla="ls -lA"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

# nginx HttpGzipModule `gzip_comp_level` default = 1
#
trygz () {
    local origsize;
    local gzipsize;
    local ratio;

    origsize=`wc -c < "$1"`;
    printf "orig: %d bytes\n" $origsize;

    gzipsize=`gzip -1 -c "$1" | wc -c`;
    ratio=`echo "$gzipsize * 100/ $origsize" | bc -l`;
    printf "gzip1: %d bytes (%2.2f%%)\n" $gzipsize $ratio;

    gzipsize=`gzip -3 -c "$1" | wc -c`;
    ratio=`echo "$gzipsize * 100/ $origsize" | bc -l`;
    printf "gzip3: %d bytes (%2.2f%%)\n" $gzipsize $ratio;

    gzipsize=`gzip -6 -c "$1" | wc -c`;
    ratio=`echo "$gzipsize * 100/ $origsize" | bc -l`;
    printf "gzip6: %d bytes (%2.2f%%)\n" $gzipsize $ratio;

    gzipsize=`gzip -9 -c "$1" | wc -c`;
    ratio=`echo "$gzipsize * 100/ $origsize" | bc -l`;
    printf "gzip9: %d bytes (%2.2f%%)\n" $gzipsize $ratio;
}

## show vcs branch name
#
# http://d.hatena.ne.jp/mollifier/20090814/p1
#
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#
# 
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
