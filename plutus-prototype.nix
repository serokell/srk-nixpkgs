{ mkDerivation, base, bifunctors, binary, bytestring, cryptonite
, fetchgit, lens, memory, mtl, parsec, stdenv, transformers
}:
mkDerivation {
  pname = "plutus-prototype";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/input-output-hk/plutus-prototype.git";
    sha256 = "14c1iksp5ic20x921b9bgbw490gc8naqn4348d08y0yc8x0sq3ys";
    rev = "ebae929cd83104fe5c0b1153c9d37d34e3a0739f";
  };
  libraryHaskellDepends = [
    base bifunctors binary bytestring cryptonite lens memory mtl parsec
    transformers
  ];
  homepage = "iohk.io";
  description = "Prototype of the Plutus language";
  license = stdenv.lib.licenses.mit;
}
