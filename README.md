```
/bin/bash <(curl -sL "https://github.com/mattjbray/dotfiles/raw/master/.local/bin/provision.sh")
```

## Nix

```
ln -sv ~/code/mattjbray/dotfiles/home-manager ~/.config/home-manager
nix run home-manager/master -- switch
```

```
nix run nix-darwin --flake ~/code/mattjbray/dotfiles/nix-darwin build
```
