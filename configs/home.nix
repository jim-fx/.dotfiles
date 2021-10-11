{ pkgs, ... }:


{

	programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.nix-direnv.enableFlakes = true;
  programs.zsh.enable = true;

	home.packages = [
		pkgs.zsh
		pkgs.direnv

		pkgs.tmux
    pkgs.tmuxPlugins.yank
    pkgs.tmuxPlugins.cpu

		pkgs.nodejs_latest

    pkgs.nodePackages.pnpm
		pkgs.nodePackages.typescript-language-server
		pkgs.nodePackages.svelte-language-server
		pkgs.nodePackages.diagnostic-languageserver
	];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jim";
  home.homeDirectory = "/home/jim";

  home.file = {
    ".zshrc".source = ./.zshrc;
    ".bashrc".source = ./.bashrc;
    ".p10k.zsh".source = ./.p10k.zsh;
    ".tmux.conf".source = ./.tmux.conf;
    ".dircolors".source = ./.dircolors;
    # ".local/share/nvim/site/pack/paqs/start/paq-nvim".source = pkgs.fetchzip {
    #   url = "https://github.com/savq/paq-nvim/archive/refs/heads/master.zip";
    # };
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
