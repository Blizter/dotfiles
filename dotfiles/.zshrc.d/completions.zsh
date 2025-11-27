complete -o nospace -C /home/ehammel/.local/bin/terraform terraform
complete -o nospace -C /home/ehammel/.local/bin/terraform tf
complete -o nospace -C /home/eric/go/bin/gocomplete go

eval "$(kind completion zsh)"
eval "$(kubectl completion zsh)"
eval "$(kustomize completion zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(podman completion zsh)"
eval "$(sops completion zsh)"