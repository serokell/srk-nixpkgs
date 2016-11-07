{ mkDerivation, array, base, bytestring, cereal, containers
, directory, extensible-exceptions, fetchgit, filepath, mtl
, network, safecopy, stdenv, stm, template-haskell, th-expand-syns
, unix
}:
mkDerivation {
  pname = "acid-state";
  version = "0.14.2";
  src = fetchgit {
    url = "https://github.com/serokell/acid-state";
    sha256 = "1g4vmqwbmp669jghig8x5zn9b6cy9f9jpm9i6l0bxwrmxjw7zhxw";
    rev = "405e41b671d3ffb17a837b45e7d01a2b635c1061";
  };
  libraryHaskellDepends = [
    array base bytestring cereal containers directory
    extensible-exceptions filepath mtl network safecopy stm
    template-haskell th-expand-syns unix
  ];
  homepage = "http://acid-state.seize.it/";
  description = "Add ACID guarantees to any serializable Haskell data structure";
  license = stdenv.lib.licenses.publicDomain;
}
