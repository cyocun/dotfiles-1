cd ~/

# brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# rvm
curl -L https://get.rvm.io | bash -s stable --ruby

# nvm
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

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

# from gem
gem install tmuxinator
gem install chef
gem install knife-solo
gem install berkshelf

# from pip
pip install --upgrade distribute
pip install pygments
pup install ansible