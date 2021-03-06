#! /bin/bash

# Path to your oh-my-bash installation.
export OSH=${HOME}/.dotfiles/oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_OSH_DAYS=3

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE= HISTFILESIZE=

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ${HOME}/.oh-my-bash/completions/*)
# Custom completions may be added to ${HOME}/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ${HOME}/.oh-my-bash/aliases/*)
# Custom aliases may be added to ${HOME}/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ${HOME}/.oh-my-bash/plugins/*)
# Custom plugins may be added to ${HOME}/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="${HOME}/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias vim="vim -u ${HOME}/.vimrc"
alias bashconfig="vim -u ${HOME}/.vimrc ${HOME}/.bashrc"
alias ohmybash="vim -u ${HOME}/.vimrc ${HOME}/.oh-my-bash"
alias sa="sudo apt"
alias update="sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade"
alias reload="source ${HOME}/.profile"
alias mkd="mkdir -pv"
alias tf="terraform "

# Functions
vim_plugins_updates () {
    # installing vim plugins
    ## creating vim plugins folders
    rm -rf ${HOME}/.vim/ &&\
        mkdir -p ${HOME}/.vim/pack/{plugins,colors}/start
    parallel -a ${HOME}/Projects/dotfiles/vim/plugins.sh
}

#autocd
shopt -s autocd

#autojump
source /usr/share/autojump/autojump.sh

#pyenv functionning
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

complete -C /usr/bin/terraform terraform
