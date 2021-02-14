{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:esbullington/nixpkgs";

  inputs.home-manager = {
    url = "github:esbullington/home-manager/release-20.09";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, home-manager, ... }@inputs:
    {
      homeConfigurations = {
        lenovo-laptop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix".source = ./configs/nix;
              nixpkgs.config = import ./configs/nix/config.nix;
              imports = [
                ./home.nix
                ./home-manager-modules/home-manager
                ./home-manager-modules/nixos-bash
                ./home-manager-modules/vim
              ];

            };
          system = "x86_64-linux";
          homeDirectory = "/home/eric";
          username = "eric";
        };
      };
      defaultPackage.x86_64-linux = self.homeConfigurations.lenovo-laptop.activationPackage;
    };
}
