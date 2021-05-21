#!/bin/bash

# This is where I want my script to start.
#cd ~/Projects/

# Let the person running the script know what's going on.
echo -e "\n\033[1mPulling in latest changes for all repositories...\033[0m\n"

PAGER=`git config  --global core.pager`
git config  --global core.pager cat


# Find all directories here - that are at least 1 level down, but don't go any further than 1 directory.
# Go into those directories and pull the repository.
for i in $(find . -maxdepth 1 -mindepth 1 -type d); do

  cd $i;


  git rev-parse --git-dir > /dev/null 2>&1
  
  if [ $? -eq 0 ]
  then
    echo -e "\033[1m"+$i+"\033[0m";  git remote -v
    BR=`git rev-parse --abbrev-ref HEAD`
    git fetch
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative "HEAD...origin/$BR"
    # git pull -q

    git pull --depth 1
    git gc --prune=all
    git tag -d $(git tag -l)
    git reflog expire --expire=all --all
  fi

  cd -
done

echo -e "\n\033[1mComplete! Do work son!\033[0m\n"

git config  --global core.pager "$PAGER"

