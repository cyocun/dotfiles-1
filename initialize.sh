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
brew install python
brew install go
brew install ec2-api-tools
brew install aws-elasticbeanstalk
brew install peco
brew install flow
brew install ffmpeg

# from gem
gem install tmuxinator -v 0.6.6

# from pip
pip install --upgrade distribute
pip install pygments
pup install awscli