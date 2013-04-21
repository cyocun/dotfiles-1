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
export EDITOR=emacs

## homebrew(usr/local/bin) prior
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

## rvm
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

## nvm
if [[ -s $HOME/.nvm/nvm.sh ]] ; then source $HOME/.nvm/nvm.sh ; fi
export NODE_PATH=${NVM_PATH}_modules

## svm
export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH

## JavaVM
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export PATH=$JAVA_HOME/bin:$PATH 

## android-sdk
export ANDROID_SDK=/Applications/android-sdk-macosx
export ANDROID_SDK_HOME=/Applications/android-sdk-macosx
export PATH=$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:$PATH

### Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## play2 framework
#export PATH=$HOME/lib/play-2.0.3:$PATH

## mine scripts & depot_tools
export PATH=$PATH:$HOME/Dropbox/Toolkit/conf/scripts
export PATH=$PATH:$HOME/Dropbox/Toolkit/conf/depot_tools

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
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
REPORTTIME=3

# historical backward/forward search with linehead string binded to ^P/^N
#
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^p" history-beginning-search-backward-end
# bindkey "^n" history-beginning-search-forward-end
bindkey "^r" zaw-history
bindkey "^t" zaw-cdr
bindkey "^g" zaw-git-branches
bindkey "^a" zaw-ack

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS     # ignore duplication command history list
setopt SHARE_HISTORY        # share command history data
     

## Completion configuration
#
#fpath=(${HOME}/.zsh/functions/Completion ${fpath})
#autoload -U compinit
#compinit


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
export LESS='-R'
export LESSOPEN='|lessfilter %s'

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias t='touch'
alias o='subl'
alias lisls='lsof -i | grep LISTEN'
alias ex='extract'
alias where="command -v"
alias j="jobs -l"
alias rmdot="find . -name '.DS_Store' -print -exec rm -r {} ';' ; find . -name ._* -e"
alias sheep='ruby -e "(1..10000).map{|n| system(\"say -v Kyoko 羊が\"+n.to_s+\"匹\");sleep 1}"'
alias run=bgrun
alias chromedev="adb forward tcp:9222 localabstract:chrome_devtools_remote"

function bgrun() {
  $* >/dev/null 2>&1 &
}

# sudo easy_install Pygments
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

## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

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

## Recently arrived directories
#
# http://shibayu36.hatenablog.com/entry/20120130/1327937835
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## like anything.el
#
# http://u7fa9.org/memo/HEAD/archives/2011-02/2011-02-22_1.rst
#
source ~/.zsh/zaw/zaw.zsh
zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに

## Directory stack select
#
# http://d.hatena.ne.jp/hchbaw/20110224/zawzsh
#
# zmodload zsh/parameter
# function zaw-src-dirstack() {
#     : ${(A)candidates::=$dirstack}
#     actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
#     act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
# }
# zaw-register-src -n dirstack zaw-src-dirstack

## Incremental completion
#
# http://mimosa-pudica.net/zsh-incremental.html
#
source ~/.zsh/incr*.zsh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
