{ mkDerivation, acid-state, aeson, aeson-extra, base
, base16-bytestring, base64-bytestring, binary, binary-orphans
, bytestring, cereal, cereal-vector, clock, containers
, data-msgpack, deepseq, directory, either, exceptions, extra
, fetchgit, filepath, formatting, hashable, hspec, lens, mtl
, optparse-applicative, parsec, QuickCheck, quickcheck-instances
, safecopy, scientific, semigroups, stdenv, template-haskell, text
, text-format, time-units, transformers, unordered-containers
, vector, yaml
}:
mkDerivation {
  pname = "serokell-core";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/serokell/serokell-core";
    sha256 = "1y7wx8yn122rxf1m8nq6qy90ky7yfw8mq30bcl8kfnvqi27f2h39";
    rev = "7ca1ea6b4e426d35652fc4e2b89c3fa864d7ac8f";
  };
  libraryHaskellDepends = [
    acid-state aeson aeson-extra base base16-bytestring
    base64-bytestring binary binary-orphans bytestring cereal
    cereal-vector clock containers data-msgpack deepseq directory
    either exceptions extra filepath formatting hashable lens mtl
    optparse-applicative parsec QuickCheck quickcheck-instances
    safecopy scientific semigroups template-haskell text text-format
    time-units transformers unordered-containers vector yaml
  ];
  testHaskellDepends = [
    aeson base binary bytestring cereal data-msgpack hspec QuickCheck
    quickcheck-instances safecopy scientific text text-format
    unordered-containers vector
  ];
  homepage = "http://gitlab.serokell.io/serokell-team/serokell-core";
  description = "General-purpose functions by Serokell";
  license = stdenv.lib.licenses.mit;
}
