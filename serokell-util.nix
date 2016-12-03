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
  pname = "serokell-util";
  version = "0.1.2.0";
  src = fetchgit {
    url = "https://github.com/serokell/serokell-util";
    sha256 = "0ab1ibm4hkadzscmhagrkka2kih6ikxj5crl5hhwm4iw0dd181q7";
    rev = "cc49e80f9b5b5bafdcaa9ad3c8a3a7b3a23ca6db";
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
  homepage = "http://gitlab.serokell.io/serokell-team/serokell-util";
  description = "General-purpose functions by Serokell";
  license = stdenv.lib.licenses.mit;
}
