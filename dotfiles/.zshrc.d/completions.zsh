complete -o nospace -C ${GOBIN}/gocomplete go
complete -o nospace -C ${ZDOTDIR:-$HOME/.asdf}/shims/terraform terraform
complete -o nospace -C ${ZDOTDIR:-$HOME/.asdf}/shims/terraform tf
complete -C '/usr/local/bin/aws_completer' aws

eval "$(flux completion zsh)"
eval "$(fzf --zsh)"
eval "$(uv --generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(flux completion zsh)"
eval "$(yq completion zsh)"

source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc

source <(kind completion zsh)
source <(kustomize completion zsh)
source <(kubectl completion zsh)
source <(grype completion zsh)
# source <(ovhcloud completion zsh)

mkdir -p "${ZDOTDIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ZDOTDIR:-$HOME/.asdf}/completions/_asdf"
