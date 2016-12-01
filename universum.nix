{ mkDerivation, async, base, bytestring, containers, deepseq
, exceptions, fetchgit, ghc-prim, mtl, safe, stdenv, stm, text
, text-format, transformers, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "universum";
  version = "0.1.9";
  src = fetchgit {
    url = "https://github.com/serokell/universum";
    sha256 = "07zbqp2cgzp3795f3z9jmgd700ccqvgj18pc2d95q7q7cc88fix0";
    rev = "d347ccf3605d0851dd0f7046fe63f364510ef1a0";
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
