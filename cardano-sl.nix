{ mkDerivation, acid-state, aeson, ansi-terminal, async, base
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory
, ed25519, exceptions, fetchgit, file-embed, filepath, formatting
, hashable, HsOpenSSL, hspec, kademlia, lens, lifted-async, log-warper
, lrucache, memory, monad-control, mtl, optparse-applicative
, optparse-simple, parsec, pvss, QuickCheck, quickcheck-instances
, random, random-shuffle, safecopy, serokell-util, stdenv, stm, stm-containers
, template-haskell, text, text-format, time, time-units, time-warp
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml, Chart, Chart-diagrams, turtle
, genesisN, slotDuration, networkDiameter, mpcRelayInterval
}:

let 
  defaultCardanoConfig = ''
    k: 6
    slotDurationSec: ${toString slotDuration}
    networkDiameter: ${toString networkDiameter}
    neighboursSendThreshold: 4
    genesisN: ${toString genesisN}
    maxLocalTxs: 10000
    mpcRelayInterval: ${toString mpcRelayInterval}
    defaultPeers: []
    sysTimeBroadcastSlots: 6
    mpcSendInterval: 18 # must be less than (k * slotDuration - networkDiameter)
  '';
in
  mkDerivation {
    pname = "cardano-sl";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/input-output-hk/pos-haskell-prototype";
      sha256 = "199lnmh8zxcw7bw4108rpv9ld42zxwngjkaw5viapfx95kxwrlnb";
      rev = "60e94199e0527c600d229242f13db0c0cd42ae57";
    };
    enableExecutableProfiling = true;
    isLibrary = true;
    isExecutable = true;
    patchPhase = ''
     echo "${defaultCardanoConfig}" > constants.yaml
    '';
    doHaddock = false;
    doCheck = false;
    libraryHaskellDepends = [
      acid-state aeson ansi-terminal async base binary binary-orphans
      bytestring cereal containers cryptonite data-default data-msgpack
      derive ed25519 exceptions file-embed formatting hashable HsOpenSSL
      kademlia lens lifted-async log-warper lrucache memory monad-control mtl parsec
      pvss QuickCheck quickcheck-instances random random-shuffle safecopy serokell-util
      stm stm-containers template-haskell text text-format time
      time-units time-warp transformers transformers-base universum
      unordered-containers UtilityTM vector yaml
    ];
    executableHaskellDepends = [
      base binary bytestring data-default directory filepath formatting log-warper
      optparse-applicative optparse-simple parsec serokell-util time-warp
      universum Chart Chart-diagrams turtle
    ];
    testHaskellDepends = [
      base binary bytestring cereal cryptonite data-msgpack formatting
      hspec log-warper memory QuickCheck random safecopy serokell-util time-units
      time-warp universum unordered-containers
    ];
    description = "Cardano SL main implementation";
    license = stdenv.lib.licenses.bsd3;
  }
