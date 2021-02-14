{ config, lib,  pkgs, ... }:

{

  imports = [
    ./home-manager-modules/home-manager
    ./home-manager-modules/nixos-bash
    ./home-manager-modules/vim
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  home.packages = with pkgs; [
    vim yarn nodejs
    gitAndTools.hub
    jq curl pass wget
    rsync pandoc dnsutils
    stack irssi
    rPackages.tidyverse
    python38Packages.ipython
    # X11 programs
    pidgin
    # makepasswd
    nox
  ];

  nixpkgs.config.allowUnfree = true; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''
    unbind-key C-b
    set-option -g prefix C-a
    set -g visual-bell off
    set-option -g history-limit 3000
    set -g pane-border-style fg=blue
    set -g pane-active-border-style fg=blue
		# Set status line background colour.
		set -g status-bg blue
		# Set status line foreground colour.
		set -g status-fg white
    setw -g mode-keys vi
    # easy vi pane navigation
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    bind '%' split-window -h -c '#{pane_current_path}'  # Split panes horizontal
    bind '"' split-window -v -c '#{pane_current_path}'  # Split panes vertically
    bind c new-window -c '#{pane_current_path}' # Create new window
  '';
  programs.tmux.plugins =  with pkgs; [
    tmuxPlugins.resurrect
  ];
  programs.tmux.keyMode = "vi";
  # programs.tmux.newSession = true;

  programs.git.enable = true;
  programs.git.userName = "Eric S Bullington";
  programs.git.userEmail = "eric@ericbullington.com";
	programs.git.extraConfig = {
    init.defaultBranch = "trunk";
  };
  programs.git.ignores = [ "*~" "*.swp" "result" ];

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;
  programs.direnv.enableBashIntegration = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = [
    pkgs.vscode-extensions.vscodevim.vim
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
