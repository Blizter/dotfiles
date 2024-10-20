# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "3h";
    options = "-d";
  };

  wsl = {
    enable = true;
    defaultUser = "Blizter";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  environment.systemPackages = with pkgs; [
    autojump
    awscli2
    azure-cli
    curl
    fzf
    git
    go
    google-cloud-sdk
    home-manager
    jq
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    localstack
    neovim
    oh-my-zsh
    parallel
    rye
    sl
    sops
    tenv
    tldr
    tmux
    unzip
    wget
    yq
    zsh
    zsh-powerlevel10k
  ];
}
