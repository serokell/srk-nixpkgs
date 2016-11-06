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
    sha256 = "1zh1ykybh6510cypx057yc0cy4i6pq64qmi7in630zhz1y25z7gj";
    rev = "7b3d9bd4a9ad5df5feee8b124805df0144304a50";
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
