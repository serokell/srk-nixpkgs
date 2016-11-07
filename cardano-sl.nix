{ mkDerivation, acid-state, aeson, ansi-terminal, async, base
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory
, ed25519, exceptions, fetchgit, file-embed, filepath, formatting
, hashable, HsOpenSSL, hspec, kademlia, lens, lifted-async
, lrucache, memory, monad-control, mtl, optparse-applicative
, optparse-simple, parsec, pvss, QuickCheck, quickcheck-instances
, random, safecopy, serokell-util, stdenv, stm, stm-containers
, template-haskell, text, text-format, time, time-units, time-warp
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml, Chart, Chart-diagrams, turtle
, genesisN 
}:

let 
  defaultCardanoConfig = ''
    k: 3
    slotDurationSec: 20
    networkDiameter: 6
    neighboursSendThreshold: 4
    genesisN: ${toString genesisN}
  '';
in
  mkDerivation {
    pname = "cardano-sl";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/input-output-hk/pos-haskell-prototype";
      sha256 = "02xfmd023rywyya53byq08jzd7vh1kf7rpi8sbg8bgqrxcf8sh1d";
      rev = "007e245d721a646e11746ed5c48a7c55575b522b";
    };
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
      kademlia lens lifted-async lrucache memory monad-control mtl parsec
      pvss QuickCheck quickcheck-instances random safecopy serokell-util
      stm stm-containers template-haskell text text-format time
      time-units time-warp transformers transformers-base universum
      unordered-containers UtilityTM vector yaml
    ];
    executableHaskellDepends = [
      base binary bytestring data-default directory filepath formatting
      optparse-applicative optparse-simple parsec serokell-util time-warp
      universum Chart Chart-diagrams turtle
    ];
    testHaskellDepends = [
      base binary bytestring cereal cryptonite data-msgpack formatting
      hspec memory QuickCheck random safecopy serokell-util time-units
      time-warp universum unordered-containers
    ];
    description = "Cardano SL main implementation";
    license = stdenv.lib.licenses.bsd3;
  }
