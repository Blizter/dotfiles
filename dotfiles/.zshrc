#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=$HOME/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[  -f ${ZDOTDIR:-$HOME}/.zstyles ] && source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# load secrets
load-secrets
source-zshrcd
manual-autocompletion

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh
