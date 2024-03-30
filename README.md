## 1. Install Nix

```
curl -sL -o nix-installer "https://github.com/DeterminateSystems/nix-installer/releases/download/v0.16.1/nix-installer-aarch64-darwin"
chmod +x ./nix-installer
./nix-installer install
```

## 2. Run nix-darwin

```
nix run nix-darwin -- --flake ~/code/mattjbray/dotfiles/nix-darwin switch
```

## Non-nix (old) - provision.sh

```
/bin/bash <(curl -sL "https://github.com/mattjbray/dotfiles/raw/master/.local/bin/provision.sh")
```
