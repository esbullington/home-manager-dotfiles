{ pkgs }:

let
  overlays = [
    (import ../../overlays/yadm)
    (import ../../overlays/vscode)
  ];
in

{

  xdg.configFile."nix".source = ../../configs/nix;
  nixpkgs.config = import ../../configs/nix/config.nix;
  nixpkgs.overlays = overlays;

}
