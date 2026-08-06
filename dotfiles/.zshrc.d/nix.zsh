# Nix: the multi-user installer only edited /etc/bashrc on this machine, not /etc/zshrc,
# so load the daemon profile here for interactive zsh.
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Inside a nix-shell only ($NIX_SHELL_PATH is set solely by that shell's hook), restore its
# PATH ahead of brew (which the main .zshrc prepends earlier). Regular shells skip this block
# entirely, so the normal environment is unchanged. typeset -U dedups, keeping the first copy.
if [ -n "$NIX_SHELL_PATH" ]; then
  export PATH="$NIX_SHELL_PATH:$PATH"
  typeset -U path PATH
fi
