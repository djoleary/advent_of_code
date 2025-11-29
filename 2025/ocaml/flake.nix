{
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
          ocamlPackages = with pkgs.ocaml-ng.ocamlPackages_5_2; [
            ocaml

            dune_3 # build system

            pkgs.opam # package manager
            findlib # library manager

            ocaml-lsp # language server
            earlybird # debug adapter
            ocamlformat # formatter

            utop # REPL

            odoc # documentation generator

            alcotest # unit test framework
            bisect_ppx # test coverage
            qcheck-core # property-based testing
            qcheck-alcotest # property-based testing
            janeStreet.ppx_inline_test # inline test library
            janeStreet.ppx_expect # inline test library

            janeStreet.re2 # regular expression library
            fmt # pretty printing library
            cmdliner # command line library
            ppx_deriving # derivers
            logs # logging library
          ];
          sysTools = with pkgs; [
            go-task
            gh
          ];
        in
        pkgs.mkShell {
          buildInputs = ocamlPackages ++ sysTools;
        };
    };
}