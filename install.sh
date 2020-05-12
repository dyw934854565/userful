#!/bin/zsh

# shell client
if test -n "$ZSH_VERSION"; then
  echo "zsh"$ZSH_VERSION
  PROFILE_SHELL=zshrc
elif test -n "$BASH_VERSION"; then
  echo "BASH_VERSION"$BASH_VERSION
  PROFILE_SHELL=bash_profile
else
  echo "BASH_VERSION2"
  PROFILE_SHELL=bash_profile
fi
RC_PATH=$HOME"/."$PROFILE_SHELL
echo "use "$RC_PATH

hasCommand() {
  local cmd="$1"
  if [ -z "$cmd" ]; then
		return 1
	fi

  if type $cmd > /dev/null 2>&1
  then
      return 0
  else
      return 2
  fi
}

# alias
if ! hasCommand "ll"
then
cat ./alias >> $RC_PATH
source $RC_PATH
fi

# 安装brew
if ! hasCommand brew
then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 使用清华的源
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git

brew update

fi

# vscode
brew cask install visual-studio-code

if ! hasCommand code
then
# Add Visual Studio Code (code)
cat << EOF >> $RC_PATH
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
source $RC_PATH
fi

# 安装vscode插件
code --install-extension shan.code-settings-sync

# nvm node
if ! hasCommand nvm
then
echo "install nvm"
brew install nvm

nvmPath="~/.nvm"
if [ ! -d "$nvmPath"]; then
  mkdir "$nvmPath"
fi

cat << EOF >> $RC_PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF

source $RC_PATH
fi

if ! hasCommand node
then
nvm install --lts
fi

# npm package -g
if ! hasCommand yarn
then
npm install -g yarn
fi

yarn global add lerna


# iterm2
brew cask install iterm2

# nginx
brew install nginx

# git flow
brew install git-flow-avh

# postman
brew cask install postman

# docker
brew cask install docker

mkdir /etc/docker
cat > /etc/docker/daemon.json << EOF
{
    "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF

brew install docker-compose