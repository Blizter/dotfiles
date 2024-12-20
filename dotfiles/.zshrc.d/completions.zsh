eval "$(zoxide init --cmd cd zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(kind completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(localstack completion zsh)"

complete -o nospace -C /home/eric/go/bin/gocomplete go
complete -o nospace -C /home/ehammel/.local/bin/terraform terraform
complete -o nospace -C /home/ehammel/.local/bin/terraform tf
complete -C '/usr/local/bin/aws_completer' aws