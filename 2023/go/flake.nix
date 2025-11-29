{
  description = "Advent of Code 2023: Go";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        # build tools
        nativeBuildInputs = with pkgs; [
          go
        ];
        # dependencies
        buildInputs = with pkgs; [
          delve
          gopls
          gotools
          golangci-lint
        ];
      };
    };
}
