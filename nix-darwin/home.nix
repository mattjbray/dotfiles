{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  opts,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/code/mattjbray/dotfiles";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${opts.username}";
  home.homeDirectory = "${opts.homeDirectory}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.bash-language-server
    pkgs.cachix
    pkgs.coreutils
    pkgs.devenv
    pkgs.emacs
    pkgs.emmet-language-server
    pkgs.fd
    pkgs.git-lfs
    pkgs.gnupg
    pkgs.htop
    pkgs.ispell
    pkgs.iterm2
    pkgs.jira-cli-go
    pkgs.jq
    pkgs.k9s
    pkgs.keybase
    pkgs.lazygit
    pkgs.lua-language-server
    pkgs.stylua
    pkgs.nixd # Nix language server
    pkgs.nix-output-monitor
    pkgs.nodejs
    pkgs.parallel
    pkgs.pinentry_mac
    pkgs.pkg-config
    pkgs.postgresql
    pkgs.prettierd
    pkgs.ripgrep
    pkgs.rlwrap
    pkgs.silver-searcher
    # pkgs.slack
    pkgs.sqlite
    pkgs.terminal-notifier
    pkgs.tig
    pkgs.tree
    pkgs.typescript-language-server
    pkgs.util-linux
    pkgs.vscode-langservers-extracted
    pkgs.watch
    pkgs.yq
    pkgs.yubikey-manager
    pkgs.yubikey-personalization
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Clone syl20bnr/spacemacs to ~/.emacs.d
  # home.file.".emacs.d" = {
  #   recursive = true;
  #   source = pkgs.fetchFromGitHub {
  #     owner = "syl20bnr";
  #     repo = "spacemacs";
  #     rev = "36b52f1b71f52718b9c35e79d35f41556529c4bd";
  #     sha256 = "sha256-ZV9TvtQECgl3DWg5A/UKkqE3vOsaR6Mgs4CYwyz2yf4=";
  #     # date = "2022-09-13T18:44:48-04:00";
  #   };
  # };

  home.file.".spacemacs.d" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.spacemacs.d";
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mattjbray/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "vi";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = {
    ll = "ls -al";
    nom-direnv-reload = "nix-direnv-reload |& nom --json";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.aerospace = {
    enable = true;
    # launchd.enable = true;
    userSettings = {
      mode.main.binding = {
        alt-enter = "fullscreen";

        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        alt-i = "workspace prev";
        alt-o = "workspace next";
        alt-shift-i = ["move-node-to-workspace prev" "workspace prev"];
        alt-shift-o = ["move-node-to-workspace next" "workspace next"];

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        alt-tab = "workspace-back-and-forth";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        # See: https://nikitabobko.github.io/AeroSpace/commands#mode
        alt-shift-semicolon = "mode service";

        alt-semicolon = "mode X";
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        alt-shift-semicolon = "mode main";
	e = ["enable toggle"];
        r = ["flatten-workspace-tree" "mode main"]; # reset layout
        f = ["layout floating tiling"]; # Toggle between floating and tiling layout
        backspace = ["close-all-windows-but-current" "mode main"];

        # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
        #s = ['layout sticky tiling', 'mode main']

        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];

        down = "volume down";
        up = "volume up";
        shift-down = ["volume set 0" "mode main"];

        enter = "fullscreen";

        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        slash = "layout tiles horizontal vertical";
        comma = "layout accordion horizontal vertical";

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        h = "focus left";
        j = "focus down";
        k = "focus up";
        l = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-h = "move left";
        alt-j = "move down";
        alt-k = "move up";
        alt-l = "move right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        minus = "resize smart -50";
        equal = "resize smart +50";
      };


      # A mode to just pass keys through!
      mode.X.binding = {
        alt-semicolon = "mode main";
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
      ".direnv/"
      ".git/"
      ".worktrees/"
    ];
    aliases = {
      btm = ''
        !main=$(git branch | grep -o -m1 '\(develop\|main\|master\)') current=$(git rev-parse --abbrev-ref HEAD) && set -x && git fetch --prune && if [[ "$main" == "$current" ]]; then git pull --ff-only origin "$main"; else git fetch origin "$main:$main"; fi && if [[ "$main" != "$current" ]] ; then git checkout "$main" && git branch -d "$current"; fi
      '';
    };
    extraConfig = {
      rebase.autoStash = true;
    };
    includes =
      if opts.github.user == "gn-matt-b"
      then [
        {
          path = "${config.home.homeDirectory}/.config/git/config.gn-matt-b";
        }
        {
          path = "${config.home.homeDirectory}/.config/git/config.mattjbray";
          condition = "gitdir:~/code/mattjbray/";
        }
      ]
      else if opts.github.user == "mattjbray"
      then [
        {
          path = "${config.home.homeDirectory}/.config/git/config.mattjbray";
        }
        {
          path = "${config.home.homeDirectory}/.config/git/config.gn-matt-b";
          condition = "gitdir:~/code/gn/";
        }
      ]
      else [];
  };

  home.file.".config/git/config.gn-matt-b" = {
    text = ''
      [commit]
          gpgSign = true
      [core]
          sshCommand = ssh -i ${config.home.homeDirectory}/.ssh/gn-matt-b.id_ed25519 -o IdentityAgent=none
      [github]
          user = gn-matt-b
      [gpg]
          format = ssh
      [gpg "ssh"]
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
      [user]
          name = Matt B
          email = matt.b@goodnotesapp.com
          signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2zrMDsXoH4wIdfJydSdS4txKj4F+wINQNAzGnt8pYm
    '';
  };

  home.file.".config/git/config.mattjbray" = {
    text = ''
      [commit]
          gpgSign = true
      [core]
          sshCommand = ssh -i ${config.home.homeDirectory}/.ssh/mattjbray.id_ed25519 -o IdentityAgent=none
      [github]
          user = mattjbray
      [gpg]
          format = ssh
      [gpg "ssh"]
          program = "ssh-keygen"
      [user]
          name = Matt Bray
          email = mattjbray@gmail.com
          signingkey = ${config.home.homeDirectory}/.ssh/mattjbray.id_ed25519.pub
    '';
  };

  programs.gh = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    package = pkgs.neovim-unwrapped;
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      UseKeychain yes
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.tmux = {
    customPaneNavigationAndResize = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    plugins = [pkgs.tmuxPlugins.cpu pkgs.tmuxPlugins.yank];
    prefix = "C-a";
    # terminal = "screen-256color";
    extraConfig = ''
      bind ^A last-window
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      set -gu default-command
      set -g default-shell "$SHELL"
    '';
  };

  programs.z-lua = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${lib.concatStringsSep ":" config.home.sessionPath}"
    '';
    initContent = ''
      # _l_ess with std_e_rr
      function le() {
        local less_args=""
        while [[ $1 = -* || $1 = +* ]]; do
          less_args="$less_args $1"
          shift
        done
        COLUMNS=$COLUMNS setsid "$@" 2>&1 | less -RS $less_args
      }

      date-ts() {
              date $@ --rfc-3339=seconds | sed 's/ /T/'
      }

      gke-pod-log() {
        if [ -z "$1" ] || [ -z "$2" ]; then
          echo "Usage: gke-pod-log PROJECT_ID POD_ID [START_TIMESTAMP:$(date-ts --date "1 day ago")]"
          return 1
        fi
        local DEFAULT_TS=$(date-ts --date "1 day ago")
        local TS="''${3:-$DEFAULT_TS}"
        local QUERY="resource.labels.pod_name=''${2} AND timestamp>=\"''${TS}\""
        gcloud --project "$1" \
            logging read "$QUERY" \
            --format='value(receiveTimestamp, firstof(textPayload, jsonPayload.message))' \
            --order asc
      }

      mksudo() {
        MINS="''${1:-5}"
        SECS=$(( $MINS * 60 ))
        echo Temporarily granting sudo access to $USER for "$MINS"m...
        DOREVOKE="echo Revoking... && dseditgroup -o edit -d $USER -t user admin && echo Revoked."
        DOGRANT="dseditgroup -o edit -a $USER -t user admin && echo Granted."
        su admin -c "sudo bash -c \"trap \\\"$DOREVOKE\\\" EXIT && "$DOGRANT" && sleep $SECS\""
      }

      # <n>ix <r>un
      nr() {
        local prog=$1
        shift
        nix run -L --inputs-from ${dotfiles}/nix-darwin nixpkgs#"$prog" -- "$@"
      }

      # <n>ix <s>shell
      ns() {
        local prog=$1
        shift
        nix shell -L --inputs-from ${dotfiles}/nix-darwin nixpkgs#"$prog"
      }

      source <(docker completion zsh)
    '';
  };
}
