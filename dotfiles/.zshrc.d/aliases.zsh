alias k=kubectl
alias kcx=kubectx
alias kns=kubens
alias ls='ls --color'
alias mkd="mkdir -pv"
alias podman="podman-remote-static-linux_amd64"
alias reload="exec zsh"
alias tf=terraform
alias vim="nvim"
alias watch="watch -n 1 "
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

alias aws2env='function(){aws sso login --color on --profile $@; eval $(aws configure export-credentials --profile $@ --format env);}'
alias aws-sso='function(){aws sso login --sso-session mistplay}'
alias brew-unlink="function(){ls -1 /opt/homebrew/Cellar /opt/homebrew/Caskroom | xargs -P8 -I {} bash -c 'brew unlink {}; brew link --overwrite --force {}'}"
