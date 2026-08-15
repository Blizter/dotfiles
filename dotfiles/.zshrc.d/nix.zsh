# Nix: the multi-user installer only edited /etc/bashrc on this machine, not /etc/zshrc,
# so load the daemon profile here for interactive zsh.
# (nix-shell tool aliases/completions live in each project's shell.nix, not here.)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
