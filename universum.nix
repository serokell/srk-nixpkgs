{ mkDerivation, async, base, bytestring, containers, deepseq
, exceptions, fetchgit, ghc-prim, mtl, safe, stdenv, stm, text
, text-format, transformers, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "universum";
  version = "0.1.9";
  src = fetchgit {
    url = "https://github.com/serokell/universum";
    sha256 = "03bvrfc6av73rzp5nw5jy048f210vwra5a63477vqlvxd8s398bz";
    rev = "8e33495fd58c5443e0c2b0f1b6646516a47bd8d6";
  };
  libraryHaskellDepends = [
    async base bytestring containers deepseq exceptions ghc-prim mtl
    safe stm text text-format transformers unordered-containers
    utf8-string
  ];
  homepage = "https://github.com/serokell/universum";
  description = "A sensible set of defaults for writing custom Preludes";
  license = stdenv.lib.licenses.mit;
}
