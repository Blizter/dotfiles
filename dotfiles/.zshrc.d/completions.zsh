# terraform or tofu, whichever this machine has. `tf` is aliased to it.
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

source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc

mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
