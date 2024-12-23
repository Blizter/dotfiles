complete -o nospace -C ${GOBIN}/gocomplete go
complete -o nospace -C /opt/homebrew/bin/terraform terraform
complete -o nospace -C /opt/homebrew/bin/terraform tf
complete -C '/usr/local/bin/aws_completer' aws

eval "$(flux completion zsh)"
eval "$(fzf --zsh)"
eval "$(kind completion zsh)"
eval "$(kind completion zsh)"
eval "$(kubectl completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(uv --generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
