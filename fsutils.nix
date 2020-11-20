{ mkDerivation, base, directory, filepath, stdenv }:
mkDerivation {
  pname = "fsutils";
  version = "0.1.4";
  src = ./.;
  libraryHaskellDepends = [ base directory filepath ];
  homepage = "https://github.com/Raynes/fsutils";
  description = "File system utilities for Haskell that are missing from built in libraries";
  license = stdenv.lib.licenses.mit;
}
ni