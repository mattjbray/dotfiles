{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      username = "mattjbray";
      system = "aarch64-darwin";
      hostname = "Matthews-MacBook-Pro-2";
      unstable = import nixpkgs-unstable { inherit system; };
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [ pkgs.vim ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Use cachix cache
        nix.settings.substituters = [ "https://nix-community.cachix.org" ];
        nix.settings.trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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

        users.users.mattjbray = {
          name = "mattjbray";
          home = "/Users/mattjbray";
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

        home-manager.extraSpecialArgs = { inherit unstable; };

        home-manager.users.mattjbray = { pkgs, unstable, config, ... }:
          import ./home.nix {
            inherit username pkgs config unstable;
            homeDirectory = "/Users/${username}";
          };
      };
    in
    rec {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Matthews-MacBook-Pro-2
      darwinConfigurations.${hostname} =
        nix-darwin.lib.darwinSystem {
          modules = [ configuration home-manager.darwinModules.default ];
        };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Matthews-MacBook-Pro-2".pkgs;

      formatter.${system} = darwinPackages.nixpkgs-fmt;
    };
}
