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
    url = "https://github.com/input-output-hk/time-warp/";
    rev = "ac8ff481d00f85cdce163b8f3cdf14bce59e1aab";
    sha256 = "114c9p67a0j9d532w8z6kha0chsrdi8h6n8w43481b7bir781zgb";
    # profiling branch
    #rev = "516daa85b7e8632ed80fa4b16476fd27bdefd7ba";
    #sha256 = "0dvfhgj3r8y7aias5c810frqnczbm3pi721pc2mrxqxbapv5rnf4";
  };

  isLibrary = true;
  isExecutable = true;
  enableLibraryProfiling = true;
  enableExecutableProfiling = true;
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
