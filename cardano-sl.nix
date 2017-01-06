{ mkDerivation, acid-state, aeson, ansi-terminal, async, base, base58-bytestring
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory, digest
, ed25519, exceptions, fetchgit, file-embed, filelock, filepath, formatting
, hashable, HsOpenSSL, hspec, http-client, http-client-tls, http-conduit
, kademlia, lens, lifted-async, log-warper
, lrucache, memory, monad-control, mtl, neat-interpolation, optparse-applicative
, optparse-simple, parsec, pvss, purescript-bridge, QuickCheck, quickcheck-instances
, random, random-shuffle, safecopy, serokell-util, stdenv, stm, stm-containers, servant-docs
, template-haskell, text, text-format, th-lift-instances, time, time-units, time-warp
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml, Chart, Chart-diagrams, turtle
, wai, wai-extra, warp, servant-server, servant
, plutus-prototype, rocksdb-haskell, deriving-compat, IfElse
, genesisN, slotDuration, networkDiameter, mpcRelayInterval
}:

let 
  defaultCardanoConfig = ''
    k: 6
    slotDurationSec: ${toString slotDuration}
    networkDiameter: ${toString networkDiameter}
    neighboursSendThreshold: 4
    genesisN: 1000 # ${toString genesisN}
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
      rev = "78ff8a42b3d17371ef19c5001d0597face3c8953";
      sha256 = "11mj5gbx9r82w1i5ayk1wvab3ai78dcyjrbda2q65fppzgn1hjg0";
      # profiling branch
      #rev = "86bbb4386635a502334bcfcea8d9800bdf4ef45e";
      #sha256 = "0vwiy273717l6237ca9pf3rmn64iw90pwil425j3lh73zivb6fyf";
    };
    # false because it's incompatible with eventlog
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
    postFixup = ''
      echo "Removing $out/lib to spare HDD space for deployments"
      rm -rf $out/lib
    '';
    libraryHaskellDepends = [
      acid-state aeson ansi-terminal async base base58-bytestring binary binary-orphans
      bytestring cereal containers cryptonite data-default data-msgpack
      derive digest ed25519 exceptions file-embed filelock formatting hashable HsOpenSSL
      http-client http-client-tls http-conduit
      kademlia lens lifted-async log-warper lrucache memory monad-control mtl
      neat-interpolation parsec servant-docs purescript-bridge
      pvss QuickCheck quickcheck-instances random random-shuffle safecopy serokell-util
      stm stm-containers template-haskell text text-format th-lift-instances time
      time-units time-warp transformers transformers-base universum
      unordered-containers UtilityTM vector yaml wai wai-extra warp servant-server servant
      plutus-prototype rocksdb-haskell deriving-compat IfElse
    ];
    executableHaskellDepends = [
      base binary bytestring data-default directory filepath formatting log-warper
      optparse-applicative optparse-simple parsec serokell-util time-warp
      universum Chart Chart-diagrams turtle plutus-prototype
    ];
    testHaskellDepends = [
      base binary bytestring cereal cryptonite data-msgpack formatting
      hspec log-warper memory QuickCheck random safecopy serokell-util time-units
      time-warp universum unordered-containers
    ];
    description = "Cardano SL main implementation";
    license = stdenv.lib.licenses.bsd3;
  }
