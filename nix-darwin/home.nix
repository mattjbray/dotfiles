{ config, pkgs, username, homeDirectory, ... }:

let dotfiles = "${config.home.homeDirectory}/code/mattjbray/dotfiles";

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "${homeDirectory}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

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

    pkgs.google-cloud-sql-proxy
    pkgs.cachix
    pkgs.coreutils
    pkgs.emacs
    (pkgs.google-cloud-sdk.withExtraComponents
      [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    pkgs.htop
    pkgs.ispell
    pkgs.jq
    pkgs.k9s
    pkgs.keybase
    pkgs.nixfmt
    pkgs.nix-output-monitor
    pkgs.parallel
    # pkgs.pinentry
    pkgs.pkg-config
    pkgs.rlwrap
    pkgs.slack
    pkgs.silver-searcher
    pkgs.sqlite
    pkgs.tig
    pkgs.tree
    pkgs.util-linux
    pkgs.watch
    pkgs.yq
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

  home.file.".emacs.d" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "4a227fc94651136a8de54bcafa7d22abe1fa0295";
      sha256 = "sha256-+pvgf+oWJQZbcvoTbQQKnQy/1X4mxtSxFdUjpfqv1f0=";
      # date = "2022-09-13T18:44:48-04:00";
    };
  };

  home.file.".local/bin/imandra_local" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.local/bin/imandra_local";
  };

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
    EDITOR = "vi";
  };

  home.shellAliases = {
    ll = "ls -al";
    nom-direnv-reload = "nix-direnv-reload |& nom --json";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    userEmail = "mattjbray@gmail.com";
    userName = "Matt Bray";
    ignores = [
      ".DS_Store"
      ".direnv/"
    ];
  };

  programs.gh = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.tmux = {
    customPaneNavigationAndResize = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    plugins = [ pkgs.tmuxPlugins.cpu pkgs.tmuxPlugins.yank ];
    prefix = "C-a";
    terminal = "screen-256color";
    extraConfig = ''
      bind ^A last-window
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    initExtra = ''
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
    '';
  };
}
