{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.gnupg
    pkgs.mill
    pkgs.wget
    pkgs.jq
    pkgs.dmenu
    pkgs.haskellPackages.xmobar
  ];

  programs.firefox.enable = true;
  services.gpg-agent.enable = true;

  programs.git = {
    enable = true;
    userName = "not2sharp";
    userEmail = "not2sharp@protonmail.com";
    aliases = {
      diffs = "diff --staged";
    };
    signing = {
      signByDefault = true;
      key = "8E51C218F8F7AE3A0BFCB9DFEC77F42F439F6FC2";
    };
  };
  programs.bash = {
    enable = true;

    historySize = 1000;
    historyFileSize = 10000;
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l  = "l -CF";
    };
    bashrcExtra = builtins.readFile .././bash/bashrc;
  };
  programs.urxvt = {
    enable = true;


    fonts = [ "xft:Terminus:pixelsize=16" ];
    iso14755 = false;
    scroll.bar = {
      enable = true;
      floating = true;
      position = "right";
      style = "plain";
    };
    scroll.lines = 5000;
    extraConfig = {
      "background" = "[85]#000000";
      "borderless" = 1;
      "depth" = 32;
      "foreground" = "[100]#ffffff";
      "geometry" = "120x30+0+0";
      "loginShell" = true;
      "perl-ext-common" = "default,matcher";
      "urlLauncher" = "firefox";
      "matcher.button" = 1;
      };
      };

      programs.vim = {
        enable = true;

        extraConfig = builtins.readFile ../config/vim/vimrc;
        plugins = [
          pkgs.vimPlugins.ctrlp
          pkgs.vimPlugins.vim-scala
          pkgs.vimPlugins.sensible
          pkgs.vimPlugins.supertab
          pkgs.vimPlugins.tabular
          pkgs.vimPlugins.vim-fugitive
          pkgs.vimPlugins.vim-gitgutter
          pkgs.vimPlugins.vim-nix
          pkgs.vimPlugins.vim-commentary
          pkgs.vimPlugins.vim-markdown
          pkgs.vimPlugins.vim-repeat
          pkgs.vimPlugins.vim-surround
          pkgs.vimPlugins.vim-vinegar
          ];

          settings = {
            expandtab = true;
            number = true;
            relativenumber = true;
            shiftwidth = 4;
            tabstop = 4;
          };
        };
        xresources =  {
          extraConfig = builtins.readFile ../x/Xresources;
        };
        xsession = {
          enable = true;

          profileExtra = builtins.readFile ../x/profileExtra;
          windowManager.xmonad = {
            enable = true;

            config = ../. + "/config/xmonad/xmonad.hs";
            enableContribAndExtras = true;
          };
        };
        home.file.".xinitrc".source = ../x/xinitrc;
        home.file.".xmobarrc".source = ../config/xmobar/xmobarrc;
      }
