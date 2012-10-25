CURRENT=`pwd`
USERDIR=`echo ~/`

echo install from $CURRENT to $USERDIR

ln -s $CURRENT/ackrc ~/.ackrc
ln -s $CURRENT/zshrc ~/.zshrc
ln -s $CURRENT/zsh ~/.zsh
ln -s $CURRENT/git_template ~/.git_template
ln -s $CURRENT/tmux.conf ~/.tmux.conf
ln -s $CURRENT/gitconfig ~/.gitconfig
ln -s $CURRENT/gitignore ~/.gitignore
ln -s $CURRENT/emacs.d ~/.emacs.d
#ln -s $CURRENT/ssh_config ~/.ssh/config
