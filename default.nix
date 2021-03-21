{ nixpkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) {},
  compiler ? "ghc901" }:
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      fsutils = self.callCabal2nix "fsutils" (gitignore ./.) {};
    };
  };
  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.fsutils
    ];
    buildInputs = [
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.wget
      nixpkgs.haskellPackages.stack
      nixpkgs.haskellPackages.ghcid
      nixpkgs.haskellPackages.stylish-haskell
      nixpkgs.haskellPackages.hlint
    ];
    # withHoogle = true;
  };
  exe = nixpkgs.haskell.lib.justStaticExecutables (myHaskellPackages.fsutils);
in
{
  inherit shell;
  inherit exe;
  inherit myHaskellPackages;
  fsutils = myHaskellPackages.fsutils;
}