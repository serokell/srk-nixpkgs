{ mkDerivation, base, bytestring, containers, fetchgit, HUnit, mtl
, network, QuickCheck, stdenv, stm, tasty, tasty-hunit
, tasty-quickcheck, transformers, transformers-compat
}:
mkDerivation {
  pname = "kademlia";
  version = "1.1.0.0";
  src = fetchgit {
    url = "https://github.com/serokell/kademlia";
    sha256 = "10y7qfxwc0zi3v3p4jcqfdkg5z9l8fy8vxv06h60b8n3di649r4s";
    rev = "062053ed11b92c8e25d4d61ea943506fd0482fa6";
  };
  doCheck = false;
  libraryHaskellDepends = [
    base bytestring containers mtl network stm transformers
    transformers-compat
  ];
  testHaskellDepends = [
    base bytestring containers HUnit mtl network QuickCheck stm tasty
    tasty-hunit tasty-quickcheck transformers transformers-compat
  ];
  homepage = "https://github.com/froozen/kademlia";
  description = "An implementation of the Kademlia DHT Protocol";
  license = stdenv.lib.licenses.bsd3;
}
