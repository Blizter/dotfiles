#! /bin/zsh
# Preferred editor for local and remote sessions
# export /bin and /usr/bin to PATH in order to avoid unwanted errors
export PATH="/usr/bin:/usr/local/bin:/bin:${HOME}/.local/bin:${PATH}"
export DOCKER_HOST='unix:///Users/eric.hammel/.local/share/containers/podman/machine/qemu/podman.sock'
# set main editor
export EDITOR="nvim"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"

[ -d "${HOME}/.krew/" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:${PATH}"
[ -d "${HOME}/.secrets/" ] && source "${HOME}/.secrets/env.sh"; echo "secrets loaded"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

source "${HOME}/.zshrc"

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/eric.hammel/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.23%252B9/OpenJDK11U-jdk_aarch64_mac_hotspot_11.0.23_9.tar.gz/jdk-11.0.23+9/Contents/Home"
# <<< JVM installed by coursier <<<
# >>> coursier install directory >>>
export PATH="$PATH:/Users/eric.hammel/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
