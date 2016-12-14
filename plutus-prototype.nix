{ mkDerivation, base, bifunctors, binary, bytestring, cryptonite
, fetchgit, lens, memory, mtl, parsec, stdenv, transformers
}:
mkDerivation {
  pname = "plutus-prototype";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/input-output-hk/plutus-prototype.git";
    sha256 = "1fcl5h57zxjbc6ra6v17h9swjgngg6qx5qdfsjvlhdmg9c7fivyr";
    rev = "f0498b9cfc7e0204cfe8709a89370f3190d3195f";
  };
  libraryHaskellDepends = [
    base bifunctors binary bytestring cryptonite lens memory mtl parsec
    transformers
  ];
  homepage = "iohk.io";
  description = "Prototype of the Plutus language";
  license = stdenv.lib.licenses.mit;
}
