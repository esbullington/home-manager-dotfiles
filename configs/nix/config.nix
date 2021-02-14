{
  allowUnfree = true;
  keep-derivations = true;
  keep-outputs = false;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        nixUnstable
      ];
    };
  };
}
