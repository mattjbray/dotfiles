{ pkgs, pkgs-unstable, self, system, opts, inputs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ pkgs.vim ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixVersions.nix_2_23;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Use cachix cache
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    # "https://anmonteiro.nix-cache.workers.dev/"
  ];
  nix.settings.trusted-substituters = [
    # "https://anmonteiro.nix-cache.workers.dev/"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    # "ocaml.nix-cache.com-1:/xI2h2+56rwFfKyyFVbkJSeGqSIYMC/Je+7XXqGKDIY="
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  users.users.${opts.username} = {
    name = opts.username;
    home = opts.homeDirectory;
  };

  # From https://nix-community.github.io/home-manager/index.xhtml#sec-install-nix-darwin-module:
  # By default, Home Manager uses a private pkgs instance that is
  # configured via the home-manager.users.<name>.nixpkgs options. To
  # instead use the global pkgs that is configured via the system level
  # nixpkgs options, set
  home-manager.useGlobalPkgs = true;
  # This saves an extra Nixpkgs evaluation, adds consistency, and removes
  # the dependency on NIX_PATH, which is otherwise used for importing
  # Nixpkgs.

  home-manager.sharedModules = [
    inputs.mac-app-util.homeManagerModules.default
  ];

  home-manager.extraSpecialArgs = {
    inherit pkgs-unstable pkgs opts;
  };

  home-manager.users.${opts.username} = import ./home.nix;
}
