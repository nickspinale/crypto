{ mkDerivation, array, base, bytestring, stdenv }:
mkDerivation {
  pname = "crypto";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ array base bytestring ];
  homepage = "https://github.com/nickspinale/crypto";
  description = "Implementations of various cryptographic standards";
  license = stdenv.lib.licenses.mit;
}
