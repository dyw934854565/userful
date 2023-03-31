#!/bin/zsh

# shell client

echo "检测命令行工具"

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

echo "安装brew，可以用它来装其他软件"
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

echo "安装vscode"
brew install --cask visual-studio-code


echo "注入code命令，可以用'code ./myproject'来打开vscode到对应目录"
if ! hasCommand code
then
# Add Visual Studio Code (code)
cat << EOF >> $RC_PATH
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
source $RC_PATH
fi

# 安装vscode插件，vscode自带同步了
# code --install-extension shan.code-settings-sync

# nvm node
echo "安装nvm管理node版本"
if ! hasCommand nvm
then
echo "install nvm"
brew install nvm

nvmPath=~/.nvm
if [ ! -d $nvmPath ]; then
  mkdir $nvmPath
fi

cat << EOF >> $RC_PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF

source $RC_PATH
fi


echo "使用nvm安装最新lts版本node"
if ! hasCommand node
then
nvm install --lts
fi

# npm package -g
echo "全局安装yarn"
if ! hasCommand yarn
then
npm install -g yarn
fi

echo "全局安装lerna package管理工具"
yarn global add lerna


# iterm2
echo "安装 iterm2"
brew install --cask iterm2

# nginx
# brew install nginx

# git flow
brew install git-flow-avh

# postman
echo "安装 postman 用于调试接口"
brew install --cask postman


# SwitchHosts
echo "安装 SwitchHosts 用于修改本地host"
brew install --cask switchhosts

# 不需要 docker
# brew install --cask docker

# mkdir /etc/docker
# cat > /etc/docker/daemon.json << EOF
# {
#     "registry-mirrors": ["https://registry.docker-cn.com"]
# }
# EOF

# brew install docker-compose


# ssh

sshPath=~/.ssh/id_rsa.pub
if [ ! -f $sshPath ]; then
    echo "生成git加密对， 可连续回车。\r\n"
    ssh-keygen -o
fi

echo "以下是公钥内容，手动复制.\r\n"

cat $sshPath

echo "\n"

echo "去github添加: https://github.com/settings/keys"

