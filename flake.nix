{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:esbullington/nixpkgs";

  inputs.home-manager = {
    url = "github:esbullington/home-manager/release-20.09";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, home-manager, ... }@inputs:
    let
      overlays = [
        (import ./overlays/yadm)
        (import ./overlays/vscode)
      ];
    in
    {
      homeConfigurations = {
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix".source = ./configs/nix;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./home.nix
                ./modules/home-manager
                ./modules/linux-bash
                ./modules/vim
              ];

            };
          system = "x86_64-linux";
          homeDirectory = "/home/eric";
          username = "eric";
        };
      };
      defaultPackage.x86_64-linux = self.homeConfigurations.linux-desktop.activationPackage;
    };
}
