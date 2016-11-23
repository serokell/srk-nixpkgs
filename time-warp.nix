{ mkDerivation, aeson, ansi-terminal, async, base, binary, binary-conduit
, bytestring, conduit, conduit-extra, containers, data-default
, data-msgpack, deepseq, errors, extra, exceptions, fetchgit, formatting, hashable, hslogger
, hspec, lens, lifted-base, log-warper, mmorph, monad-control, monad-loops
, MonadRandom, mtl, network, optparse-simple, pqueue, QuickCheck
, quickcheck-instances, random, regex-tdfa, safe, semigroups, serokell-util
, slave-thread, stdenv, stm, stm-chans, stm-conduit
, streaming-commons, template-haskell, text, text-format, time
, time-units, transformers, transformers-base, unordered-containers, yaml
}:
mkDerivation {
  pname = "time-warp";
  version = "1.1.0.1";
  src = fetchgit {
    url = "https://github.com/serokell/time-warp/";
    sha256 = "132935zb0gfs97jsh365h6jv7931fkj3d6rjjz1hcz1ha3aazpxq";
    rev = "7e45246de423ea7b510b416c613911e63d98d2c3";
  };

  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-terminal base binary binary-conduit bytestring conduit
    conduit-extra containers data-default data-msgpack deepseq
    exceptions extra errors
    formatting hashable hslogger lens lifted-base log-warper mmorph
    monad-control monad-loops MonadRandom mtl network pqueue QuickCheck
    quickcheck-instances random safe semigroups serokell-util
    slave-thread stm stm-chans stm-conduit streaming-commons
    template-haskell text text-format time time-units transformers
    transformers-base unordered-containers yaml
  ];
  executableHaskellDepends = [
    async base binary binary-conduit conduit data-default data-msgpack
    exceptions formatting hspec lens MonadRandom mtl optparse-simple
    QuickCheck random regex-tdfa
    serokell-util stm text text-format time-units transformers
  ];
  testHaskellDepends = [
    async base data-default data-msgpack exceptions hspec lens mtl
    QuickCheck random serokell-util stm text text-format time-units
    transformers
  ];
  homepage = "http://gitlab.serokell.io/serokell-team/time-warp";
  description = "distributed systems execution emulation";
  license = stdenv.lib.licenses.gpl3;
}
