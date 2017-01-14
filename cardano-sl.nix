{ mkDerivation, acid-state, aeson, ansi-terminal, async, base, base58-bytestring
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory, digest
, ed25519, exceptions, fetchgit, file-embed, filelock, filepath, formatting
, hashable, HsOpenSSL, hspec, http-client, http-client-tls, http-conduit
, kademlia, lens, lifted-async, log-warper
, lrucache, memory, monad-control, mtl, neat-interpolation, optparse-applicative
, optparse-simple, parsec, pvss, purescript-bridge, QuickCheck, quickcheck-instances
, random, random-shuffle, safecopy, serokell-util, stdenv, stm, stm-containers, servant-docs
, template-haskell, text, text-format, th-lift-instances, time, time-units, time-warp, tw-rework-sketch
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml, Chart, Chart-diagrams, turtle
, wai, wai-websockets, wai-extra, warp, websockets, servant-server, servant
, plutus-prototype, rocksdb-haskell, deriving-compat, IfElse
, genesisN, slotDuration, networkDiameter, mpcRelayInterval
}:

let 
  defaultCardanoConfig = ''

    # Fundamental constants for core protocol
    k: 6
    slotDurationSec: ${toString slotDuration}
    
    # Networking
    networkDiameter: ${toString networkDiameter}
    neighboursSendThreshold: 4
    networkConnectionTimeout: 2000

    # Time slave/lord
    sysTimeBroadcastSlots: 6

    genesisN: 1000 # ${toString genesisN}
    maxLocalTxs: 10000
    defaultPeers: []
    mdNoBlocksSlotThreshold: 10
    mdNoCommitmentsEpochThreshold: 3
    protocolMagic: 0
    enhancedMessageBroadcast: 2
    blockRetrievalQueueSize: 100

    # GodTossing
    vssMaxTTL: 10 # epochs
    vssMinTTL: 2 # epochs
    mpcSendInterval: 12 # must be less than (k * slotDuration - networkDiameter)
    mpcThreshold: 0.01 # 1% of stake

    # delegation
    maxBlockProxySKs: 10000
    delegationThreshold: 0.005 # 0.5% of stake
    ntpResponseTimeout: 1000000 # 1 sec
    ntpPollDelay: 300000000 # 300 sec

    # update mechanism
    updateServers: []
    updateProposalThreshold: 0.1 # 10% of total stake
    updateVoteThreshold: 0.001 # 0.1% of total stake
    updateImplicitApproval: 40000 # slots    
  '';
in
  mkDerivation {
    pname = "cardano-sl";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/input-output-hk/pos-haskell-prototype";
      #  tests-stable (works)
      #rev = "4590e674642d59cfa2cd7e226a0a869f3ca35929";
      #sha256 = "1zsqavpnqagzr1n4wrgp5x7hlv4iybgwgq337ngh72yd4zxsxndi";
      #  new master
      rev = "6fe78dd4ac0975183b24e51025e83fa5649bb14e";
      sha256 = "1r451n38b191aq4y27mlalpf59rxhgxx57qmvk6axpmkhv4z5amp";
      #  profiling branch
      #rev = "86bbb4386635a502334bcfcea8d9800bdf4ef45e";
      #sha256 = "0vwiy273717l6237ca9pf3rmn64iw90pwil425j3lh73zivb6fyf";
    };
    # false because it's incompatible with eventlog
    enableExecutableProfiling = false;
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
      time-units time-warp transformers transformers-base tw-rework-sketch universum
      unordered-containers UtilityTM vector yaml wai wai-extra warp servant-server servant
      plutus-prototype rocksdb-haskell deriving-compat IfElse
      wai-websockets websockets
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
