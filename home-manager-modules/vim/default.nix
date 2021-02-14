{ pkgs, ... }:

{

  xdg.configFile."vim".source = ../../configs/vim;
  # programs.vim.enable = true;
  # programs.vim.plugins = [
  #   pkgs.vimPlugins.coc-nvim
  # ];

}
