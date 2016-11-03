{ mkDerivation, acid-state, aeson, ansi-terminal, async, base
, binary, binary-orphans, bytestring, cereal, containers
, cryptonite, data-default, data-msgpack, derive, directory
, ed25519, exceptions, fetchgit, file-embed, filepath, formatting
, hashable, HsOpenSSL, hspec, kademlia, lens, lifted-async
, lrucache, memory, monad-control, mtl, optparse-applicative
, optparse-simple, parsec, pvss, QuickCheck, quickcheck-instances
, random, safecopy, serokell-core, stdenv, stm, stm-containers
, template-haskell, text, text-format, time, time-units, time-warp
, transformers, transformers-base, universum, unordered-containers
, UtilityTM, vector, yaml
, genesisN ? 3
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
      sha256 = "0f7ymz2hkchc0l62b03z4128k7w7m24885l5y78q8iac7d71ajlr";
      rev = "6221a80026e1cabfe90b8a10994df0486d84ceac";
    };
    isLibrary = true;
    isExecutable = true;
    patchPhase = ''
     echo "${defaultCardanoConfig}" > constants.yaml
    '';
    libraryHaskellDepends = [
      acid-state aeson ansi-terminal async base binary binary-orphans
      bytestring cereal containers cryptonite data-default data-msgpack
      derive ed25519 exceptions file-embed formatting hashable HsOpenSSL
      kademlia lens lifted-async lrucache memory monad-control mtl parsec
      pvss QuickCheck quickcheck-instances random safecopy serokell-core
      stm stm-containers template-haskell text text-format time
      time-units time-warp transformers transformers-base universum
      unordered-containers UtilityTM vector yaml
    ];
    executableHaskellDepends = [
      base binary bytestring data-default directory filepath formatting
      optparse-applicative optparse-simple parsec serokell-core time-warp
      universum
    ];
    testHaskellDepends = [
      base binary bytestring cereal cryptonite data-msgpack formatting
      hspec memory QuickCheck random safecopy serokell-core time-units
      time-warp universum unordered-containers
    ];
    description = "Cardano SL main implementation";
    license = stdenv.lib.licenses.bsd3;
  }
