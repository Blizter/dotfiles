# Dotfiles for macOS

Zsh setup managed with [antidote](https://getantidote.github.io/) (plugins) and [GNU stow](https://www.gnu.org/software/stow/) (symlinking).

## Install

1. Install iTerm2
2. Clone this repo
3. Run `install.sh`

`install.sh` installs Homebrew deps (see commented-out block at top — uncomment/edit as needed), fetches nvm/uv/kustomize/kubectx/kubens/AWS CLI v2, clones tpm (tmux plugin manager), then stows `dotfiles/dotfiles` into `$HOME`.

## Layout

- `dotfiles/.zshenv` — env vars, PATH, XDG dirs, editor, DOCKER_HOST, nvm init
- `dotfiles/.zshrc` — interactive shell setup (sources `.zfunctions`, `.zshrc.d`, plugins)
- `dotfiles/.zsh_plugins.txt` — antidote plugin list (p10k, fzf-tab, syntax highlighting, autosuggestions, OMZ plugins for aws/git/kubectl/terraform/direnv/etc.)
- `dotfiles/.zfunctions/` — autoloaded helper functions (`source-zshrcd`, `source-helpers`, `load-secrets`, `is-macos`, `manual-autocompletion`)
- `dotfiles/.zshrc.d/` — sourced on every shell: `aliases.zsh`, `completions.zsh`, `history.zsh`
- `dotfiles/.p10k.zsh` — Powerlevel10k prompt config
- `dotfiles/.tmux.conf` — tmux config (uses tpm)
- `dotfiles/.config/nvim` — Neovim config
- `catppuccin-mocha.itermcolors` — iTerm2 color scheme

## Notes

- Secrets: drop files in `$SECRETS_HOME` (`~/.local/secrets`), auto-sourced by `load-secrets`.
- Local helper scripts: drop in `$HELPERS_HOME` (`~/.local/helpers`), auto-sourced by `source-helpers`.
- `restow` alias re-runs stow to relink after edits.
