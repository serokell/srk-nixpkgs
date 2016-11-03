{ mkDerivation, ansi-terminal, async, base, binary, binary-conduit
, bytestring, conduit, conduit-extra, containers, data-default
, data-msgpack, deepseq, exceptions, fetchgit, formatting, hslogger
, hspec, lens, lifted-base, mmorph, monad-control, monad-loops
, MonadRandom, mtl, network, pqueue, QuickCheck
, quickcheck-instances, random, safe, semigroups, serokell-core
, slave-thread, stdenv, stm, stm-chans, stm-conduit
, streaming-commons, template-haskell, text, text-format, time
, time-units, transformers, transformers-base
}:
mkDerivation {
  pname = "time-warp";
  version = "0.1.0.0";
  src = fetchgit {
    url = "http://github.com/serokell/time-warp";
    sha256 = "0gz7vyz65ab9invbs6n1d5izxkh7l08ywrh9v8ik79sa1rqc64kv";
    rev = "6645c7c99b70b8230a02a102c1ce10701f721f76";
  };
  isLibrary = true;
  isExecutable = true;
  doHaddock = false;
  libraryHaskellDepends = [
    ansi-terminal base binary binary-conduit bytestring conduit
    conduit-extra containers data-default data-msgpack deepseq
    exceptions formatting hslogger lens lifted-base mmorph
    monad-control monad-loops MonadRandom mtl network pqueue QuickCheck
    quickcheck-instances random safe semigroups serokell-core
    slave-thread stm stm-chans stm-conduit streaming-commons
    template-haskell text text-format time time-units transformers
    transformers-base
  ];
  executableHaskellDepends = [
    async base binary binary-conduit conduit data-default data-msgpack
    exceptions formatting hspec lens MonadRandom mtl QuickCheck random
    serokell-core stm text text-format time-units transformers
  ];
  testHaskellDepends = [
    async base data-default data-msgpack exceptions hspec lens mtl
    QuickCheck random serokell-core stm text text-format time-units
    transformers
  ];
  homepage = "http://gitlab.serokell.io/serokell-team/time-warp";
  description = "distributed systems execution emulation";
  license = stdenv.lib.licenses.gpl3;
}
