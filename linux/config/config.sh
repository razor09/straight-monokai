export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

function ask() {
  git add --all
  if [[ $1 != "" ]]; then
    git commit -m $1
  else
    git commit -m update
  fi
  git push origin master
}

function pls() {
  git pull
  if [[ $1 == "a" ]]; then
    npm run fetch
    npm run build
  else
    npm run update
    ask
  fi
}

function clear-history() {
  local folder="${PWD##*/}"
  local repository="git@github.com:razor09/$folder.git"
  rm -rf .git
  git init
  git remote add origin $repository
  git add --all
  git commit -m update
  git push -f origin master
  cd ../ && rm -rf $folder
  git clone $repository
  cd $folder
  npm run fetch
  npm run build
}

function golang-update() {
  if [[ $1 != "" ]]; then
    local url=https://go.dev/dl
    local file=go$1.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    wget ${url}/${file}
    sudo tar -C /usr/local -xzf ${file}
    rm ${file}
  fi
}

function node-update() {
  local current=$(nvm current)
  nvm install --lts --latest-npm
  nvm uninstall $current
}

function up() {
  sudo snap refresh
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
  sudo rm -rf /var/crash/* || echo
  node-update || echo
  omz update
}

function dsstore() {
  find . -name ".DS_Store" -type f -delete
}

alias cls="reset"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Code/go/libs

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
