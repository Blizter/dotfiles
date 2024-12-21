complete -C '/usr/local/bin/aws_completer' aws
complete -o nospace -C /home/ehammel/.local/bin/terraform terraform
complete -o nospace -C /home/ehammel/.local/bin/terraform tf
complete -o nospace -C /home/eric/go/bin/gocomplete go

eval "$(kind completion zsh)"
eval "$(kubectl completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(localstack completion zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(zellij setup --generate-auto-start zsh)"
eval "$(zoxide init --cmd cd zsh)"
