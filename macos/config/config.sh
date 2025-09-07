export ZSH="/Users/razor/.oh-my-zsh"

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

function up() {
  local current=$(nvm current)
  nvm install --lts --latest-npm
  nvm uninstall $current
  omz update
}

function dsstore() {
  find . -name ".DS_Store" -type f -delete
}

export GOPATH=$HOME/Code/go/libs

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
