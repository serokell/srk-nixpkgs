{ mkDerivation, async, base, bytestring, containers, deepseq
, exceptions, fetchgit, ghc-prim, mtl, safe, stdenv, stm, text
, text-format, transformers, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "universum";
  version = "0.1.8";
  src = fetchgit {
    url = "https://github.com/serokell/universum";
    sha256 = "17bsvn9jg0ans2168cwkr73vb4ikc3g9n5kjppkrjd9svw6zpjnb";
    rev = "a91badb3b306fb6816dbe761a7148895bc8cf789";
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
