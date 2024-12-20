complete -o nospace -C ${GOBIN}/gocomplete go
complete -o nospace -C /opt/homebrew/bin/terraform terraform
complete -o nospace -C /opt/homebrew/bin/terraform tf
complete -C '/usr/local/bin/aws_completer' aws

eval "$(kind completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

source <(uvx --generate-shell-completion zsh)
source <(uv --generate-shell-completion zsh)
source <(kubectl completion zsh)
source <(flux completion zsh)
source <(kind completion zsh)
