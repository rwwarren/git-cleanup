#!/bin/bash
repoLocation=""
cleanupRepo() {

  stash() {
    git stash
  }

  pull() {
    git pull origin master
  }

  changeBranch() {
    git checkout $1
  }

  merge() {
    git merge master
  }

  pop() {
    git stash pop
  }

  prune() {
    git branch --no-color --merged | command grep -vE "^(\*|\s*(master)\s*$)" | command xargs -n 1 git branch -d
  }

  git_current_branch () {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]
    then
        [[ $ret = 128 ]] && return
        ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
    fi
    echo ${ref#refs/heads/}
  }

  intialBranch=$(git_current_branch)
  stashResult=$(stash)
  #check if intial was master
  if [ "$intialBranch" != "master" ]; then
    echo $(changeBranch master)
  fi
  echo $(pull)
  #check if intial was master
  if [ "$intialBranch" != "master" ]; then
    echo $(changeBranch $intialBranch)
  fi
  echo $(merge)
  #dont if nothing was stashed
  if [ "$stashResult" != "No local changes to save" ]; then
    echo $(pop)
  fi
  echo $(prune)

}

cleanupPorch() {
  currentDir=$(pwd)
  cd $repoLocation
  for d in */ ; do
    cd $d
    echo "$d"
    cleanupRepo
    cd ../
  done
  cd $currentDir
}

alias cleanup=cleanupPorch
