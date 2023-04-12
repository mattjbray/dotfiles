```
/bin/bash <(curl -sL "https://github.com/mattjbray/dotfiles/raw/master/.local/bin/provision.sh")
```

## Nix

```
nix run home-manager/master -- switch --flake ~/code/mattjbray/dotfiles/.config/home-manager                                                                                                                   ~
```

