{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/292fa7d4f6519c074f0a50394dbbe69859bb6043";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    mac-app-util,
    flake-utils,
  }: let
    opts = {
      home = rec {
        system = "x86_64-darwin";
        username = "mattjbray";
        homeDirectory = "/Users/${username}";
        github.user = "mattjbray";
      };
      work = rec {
        system = "aarch64-darwin";
        username = "mattjbray";
        homeDirectory = "/Users/${username}";
        github.user = "gn-matt-b";
      };
    };

    mkDarwinConfiguration = opts: let
      system = opts.system;
      # pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable {inherit system;};
    in
      nix-darwin.lib.darwinSystem {
        modules = [
          mac-app-util.darwinModules.default
          ./configuration.nix
          home-manager.darwinModules.default
        ];
        specialArgs = {inherit inputs pkgs-unstable self system opts;};
      };

    mkHomeConfiguration = opts: let
      system = opts.system;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {inherit system;};
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          mac-app-util.homeManagerModules.default
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable opts;
        };
      };
    configs = {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      darwinConfigurations.home = mkDarwinConfiguration opts.home;

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.home.pkgs;

      # Build darwin flake using:
      # $ home-manager build --flake .#work
      homeConfigurations.work = mkHomeConfiguration opts.work;
    };
  in
    configs
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        formatter = pkgs.alejandra;
      }
    );
}
