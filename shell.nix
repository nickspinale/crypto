{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, array, base, bytestring, stdenv }:
      mkDerivation {
        pname = "crypto";
        version = "0.1.0.0";
        src = ./.;
        libraryHaskellDepends = [ array base bytestring ];
        homepage = "https://github.com/nickspinale/crypto";
        description = "Implementations of various cryptographic standards";
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
