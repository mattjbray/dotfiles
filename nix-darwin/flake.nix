{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager, mac-app-util }:
    let
      username = "mattjbray";
      homeDirectory = "/Users/${username}";
      system = "x86_64-darwin";
      hostname = "Matthews-MacBook-Pro";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in
    rec {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Matthews-MacBook-Pro-2
      darwinConfigurations.${hostname} =
        nix-darwin.lib.darwinSystem {
          modules = [
            mac-app-util.darwinModules.default
            ./configuration.nix
            home-manager.darwinModules.default
          ];
          specialArgs = { inherit inputs pkgs-unstable self system username; };
        };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.${hostname}.pkgs;

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit pkgs-unstable username homeDirectory; };
      };

      formatter.${system} = darwinPackages.nixpkgs-fmt;
    };
}
