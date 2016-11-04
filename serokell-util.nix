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
  version = "0.1.1";
  src = fetchgit {
    url = "https://github.com/serokell/serokell-util";
    sha256 = "0vb9v6qpcwbly3lr7vbal200q77cjzxlnnnwgnc6y6msbxkpn6qr";
    rev = "3fd9a911211276f1f2a2a9fe78bddbb2e1ffd503";
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
