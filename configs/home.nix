{ config, pkgs, ... }:

{

	programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.nix-direnv.enableFlakes = true;
  programs.zsh.enable = true;

	home.packages = [
		pkgs.neovim
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

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jim";
  home.homeDirectory = "/home/jim";

	xdg.configFile."nvim/init.lua".source = ./init.lua;
	home.file.".zshrc".source = ./.zshrc;
	home.file.".bashrc".source = ./.bashrc;
	home.file.".p10k.zsh".source = ./.p10k.zsh;
	home.file.".tmux.conf".source = ./.tmux.conf;
	home.file.".dircolors".source = ./.dircolors;

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
