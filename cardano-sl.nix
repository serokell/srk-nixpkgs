{ mkDerivation, acid-state, aeson, ansi-terminal, async, base, base58-bytestring
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory, digest
, ed25519, exceptions, fetchgit, file-embed, filepath, formatting
, hashable, HsOpenSSL, hspec, kademlia, lens, lifted-async, log-warper
, lrucache, memory, monad-control, mtl, optparse-applicative
, optparse-simple, parsec, pvss, QuickCheck, quickcheck-instances
, random, random-shuffle, safecopy, serokell-util, stdenv, stm, stm-containers
, template-haskell, text, text-format, time, time-units, time-warp
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml, Chart, Chart-diagrams, turtle
, wai, wai-extra, warp, servant-server, servant
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
      sha256 = "1cfw8y41s53mhfd0g45z75zakg5wva45xgh8nx7l121rb0krjksa";
      rev = "2e471924cb38969b9b7a8eec7f9e4b3696882d06";
    };
    enableExecutableProfiling = true;
    # Build statically to reduce closure size
    enableSharedLibraries = false;
    enableSharedExecutables = false;
    isLibrary = false;
    isExecutable = true;
    patchPhase = ''
     echo "${defaultCardanoConfig}" > constants.yaml
    '';
    doHaddock = false;
    configureFlags = [ "-f-asserts" "-fwith-wallet" ];
    doCheck = false;
    libraryHaskellDepends = [
      acid-state aeson ansi-terminal async base base58-bytestring binary binary-orphans
      bytestring cereal containers cryptonite data-default data-msgpack
      derive digest ed25519 exceptions file-embed formatting hashable HsOpenSSL
      kademlia lens lifted-async log-warper lrucache memory monad-control mtl parsec
      pvss QuickCheck quickcheck-instances random random-shuffle safecopy serokell-util
      stm stm-containers template-haskell text text-format time
      time-units time-warp transformers transformers-base universum
      unordered-containers UtilityTM vector yaml wai wai-extra warp servant-server servant
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
