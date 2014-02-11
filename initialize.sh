cd ~/

# brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
anyenv install rbenv
anyenv install ndenv

# from Homebrew
brew install ack
brew install emacs
brew install tmux
brew install git
brew install hub
brew install wget
brew install tree
brew install pstree
brew install phantomjs
brew install casperjs
brew install closure-compiler
brew install imagesnap
brew install python
brew install go

# from gem
gem install tmuxinator
gem install chef
gem install knife-solo
gem install berkshelf

# from pip
pip install --upgrade distribute
pip install pygments
pup install ansible