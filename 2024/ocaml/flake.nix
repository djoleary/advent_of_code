{
  description = "Advent of Code 2024: OCaml";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default =
        let
          ocamlPackages = pkgs.ocaml-ng.ocamlPackages_5_2;
        in
        pkgs.mkShell {
          # build tools
          nativeBuildInputs = with ocamlPackages; [
            pkgs.opam
            ocaml
            findlib
            dune_3
          ];
          # dependencies
          buildInputs = with ocamlPackages; [
            bisect_ppx
            findlib
            menhir
            ocaml-lsp
            earlybird
            ocamlformat
            ocamlgraph
            odoc
            ounit2
            re2
            utop

            pkgs.gh # GitHub CLI
          ];
        };
    };
}
