{
  description = "Monolithic development flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/26.05";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
  in
  {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "idea"
        ];
      };
    in {
      default = pkgs.callPackage ./nix/devShell.nix { inherit inputs; };
    });
  };
}
