 # some handy aliasses
``` bash
# Lazy sshing
alias ssd="sshpass -p 'supersecure' ssh -o  StrictHostKeyChecking=no $1"

# typos
alias gti="git  $1"
alias sl="ls  $1"
alias bim="vim $1"
alias vd="cd $1"

# get a random password
alias genpwd="cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 25 | head -n 1"

# A git one liner to commit everything at once
gadd() { git add . && git commit -m "$1" && git push }

# Update all the repositories in current PWD
gupd() { for DIR in $(ls ${1}); do stp=$(pwd) && cd ${stp}/${1}/$DIR && git pull && cd $stp; done}

# make a directory and move in it
mdk() { mkdir -p "$1" && cd "$1"; }

# go up $1 amount of directories
up() { cd $(printf "%0.s../" $(seq 1 $1 )); }
```
