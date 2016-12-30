# Git
alias gs="git status --short"
alias gss="git status"
alias gl='git log --graph --pretty=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)" --abbrev-commit --date=relative'
alias gls='git log --pretty=format:"%h - %an, %ar : %s" -n 20'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gb='git branch -a'
alias git.amend='git commit --amend -m'
alias git.upmod='git commit -m "Update submodule"'
alias git.diff='git difftool'
alias git.all='git add -u .'
alias git.reset='git reset --hard'
alias git.bump="mversion"
alias git.check='alias git branch -r | xargs -t -n 1 git branch -r --contains'
alias git.subpull='git pull && git submodule init && git submodule update && git submodule status'

# Git flow
alias gf.init="git flow init -d"
alias gf.f="git flow feature start"
alias gf.ff="git flow feature finish"
alias gf.fp="git flow feature publish"
alias gf.h="git flow hotfix start"
alias gf.ff="git flow hotfix finish"
alias gf.r="git flow release start"
alias gf.fr="git flow release finish"
alias gf.s="git flow support start"
