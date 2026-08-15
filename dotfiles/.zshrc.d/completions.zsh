# Completions for CLI tools. Every entry guarded by $+commands, so nothing fires when a tool is
# absent — clean in the base env, lights up wherever the tool exists (e.g. inside a nix-shell).
#
# ez-compinit queues every `compdef` until it runs compinit at the first prompt, so registering
# here (before compinit) is fine. bashcompinit only has to precede the first `complete -C`.
autoload -Uz bashcompinit && bashcompinit

# terraform or tofu, whichever this machine has. `tf` is aliased to it (see aliases.zsh).
for _c in terraform tofu; do
  (( $+commands[$_c] )) && complete -o nospace -C "$commands[$_c]" $_c tf
done

(( $+commands[aws_completer] )) && complete -C "$commands[aws_completer]" aws
(( $+commands[gocomplete] )) && complete -o nospace -C "$commands[gocomplete]" go

(( $+commands[fzf] )) && eval "$(fzf --zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init --cmd cd zsh)"

for _c in uv uvx; do
  (( $+commands[$_c] )) && eval "$($_c --generate-shell-completion zsh)"
done

for _c in flux plumber yq; do
  (( $+commands[$_c] )) && eval "$($_c completion zsh)"
done

for _c in grype kind kubectl kustomize; do
  (( $+commands[$_c] )) && source <($_c completion zsh)
done
unset _c

# complete the `k` alias like kubectl (alias in aliases.zsh).
(( $+commands[kubectl] )) && compdef k=kubectl

# gcloud ships completion + PATH as sourceable scripts (guarded: absent on non-mac / no cask).
gcloud_sdk=/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk
[[ -d $gcloud_sdk ]] && {
  source "$gcloud_sdk/completion.zsh.inc"
  source "$gcloud_sdk/path.zsh.inc"
}
unset gcloud_sdk

# ponytail: regenerates _asdf every startup; add an `[[ -f ]]` guard if it hits startup time.
(( $+commands[asdf] )) && {
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
}
