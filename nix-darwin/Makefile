.PHONY: run-darwin-rebuild-personal
run-darwin-rebuild-personal:
	sudo nix run -L --inputs-from . nix-darwin#darwin-rebuild -- switch --flake .#personal

.PHONY: run-home-manager-personal
run-home-manager-personal:
	nix run -L --inputs-from . nixpkgs#home-manager -- switch --flake .#personal

.PHONY: run-home-manager-work
run-home-manager-work:
	nix run -L --inputs-from . nixpkgs#home-manager -- switch --flake .#work

.PHONY: format
format:
	nix fmt .

