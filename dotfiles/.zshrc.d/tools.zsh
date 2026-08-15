# Completions for CLI tools I use (opentofu, kubectl, flux, ...). Aliases live in aliases.zsh.
# Every line is guarded by `command -v`, so nothing fires when a tool is absent — no errors in
# the base environment; it lights up only where the tool exists (e.g. inside a nix-shell).
#
# No deferral needed: ez-compinit queues every `compdef` call until it runs compinit at the
# first prompt, so native completions register at load. bashcompinit just has to come before
# the first `complete -C` (registration is queued the same way).
autoload -Uz bashcompinit && bashcompinit

# bash-style self-completing binaries (complete -C uses terraform's COMP_LINE protocol).
# opentofu has no native zsh completion; covers `tofu` and the `tf` alias.
command -v tofu          >/dev/null && complete -o nospace -C "$(command -v tofu)" tofu tf
command -v gocomplete    >/dev/null && complete -o nospace -C "$(command -v gocomplete)" go
command -v aws_completer >/dev/null && complete -C "$(command -v aws_completer)" aws

# native zsh completions via eval.
command -v fzf    >/dev/null && eval "$(fzf --zsh)"
command -v uv     >/dev/null && eval "$(uv --generate-shell-completion zsh)"
command -v uvx    >/dev/null && eval "$(uvx --generate-shell-completion zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"
command -v yq     >/dev/null && eval "$(yq completion zsh)"

# native zsh completions via source <(...). kubectl / flux also wire the alias (see aliases.zsh).
command -v kubectl   >/dev/null && { source <(kubectl completion zsh); compdef k=kubectl; }
command -v flux      >/dev/null && { source <(flux completion zsh); compdef fx=flux; }
command -v kind      >/dev/null && source <(kind completion zsh)
command -v kustomize >/dev/null && source <(kustomize completion zsh)
command -v grype     >/dev/null && source <(grype completion zsh)

# gcloud ships completion + PATH as sourceable scripts (self-contained: runs its own bashcompinit).
gcloud_sdk=/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk
[[ -d $gcloud_sdk ]] && {
  source "$gcloud_sdk/completion.zsh.inc"
  source "$gcloud_sdk/path.zsh.inc"
}
unset gcloud_sdk
