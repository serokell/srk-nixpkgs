{ mkDerivation, ansi-terminal, async, base, binary, binary-conduit
, bytestring, conduit, conduit-extra, containers, data-default
, data-msgpack, deepseq, exceptions, fetchgit, formatting, hslogger
, hspec, lens, lifted-base, mmorph, monad-control, monad-loops
, MonadRandom, mtl, network, pqueue, QuickCheck
, quickcheck-instances, random, safe, semigroups, serokell-util
, slave-thread, stdenv, stm, stm-chans, stm-conduit
, streaming-commons, template-haskell, text, text-format, time
, time-units, transformers, transformers-base
}:
mkDerivation {
  pname = "time-warp";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/serokell/time-warp/";
    sha256 = "1k0qhdri18zhaqa46nqkml5fq1yxcvcv076icr0a0nr50ihnp5gb";               
    rev = "47a91c82f0875e91bbed1fa1ea18c1df968841f5";
  };

  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    ansi-terminal base binary binary-conduit bytestring conduit
    conduit-extra containers data-default data-msgpack deepseq
    exceptions formatting hslogger lens lifted-base mmorph
    monad-control monad-loops MonadRandom mtl network pqueue QuickCheck
    quickcheck-instances random safe semigroups serokell-util
    slave-thread stm stm-chans stm-conduit streaming-commons
    template-haskell text text-format time time-units transformers
    transformers-base
  ];
  executableHaskellDepends = [
    async base binary binary-conduit conduit data-default data-msgpack
    exceptions formatting hspec lens MonadRandom mtl QuickCheck random
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
