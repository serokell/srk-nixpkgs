{ pkgs } :

with pkgs; rec {
  universum = hspkgs.mkDerivation {
    pname = "universum";
    version = "0.1.8";
    src = fetchgit {
      url = "https://github.com/serokell/universum.git";
      sha256 = "0rg8m41r32a0g0izirj2kmc0c4nry98nsbqdpbr5s7mz13qnh10h";
      rev = "0d50a67184025479df08b207f41710e2e2478e65";
    };
    libraryHaskellDepends = with hspkgs; [
      async base bytestring containers deepseq exceptions ghc-prim mtl
      safe stm text text-format transformers unordered-containers
    ];
    homepage = "https://github.com/serokell/universum";
    description = "A sensible set of defaults for writing custom Preludes";
    license = stdenv.lib.licenses.mit;
  };

  serokell-core = hspkgs.mkDerivation {
    pname = "serokell-core";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/serokell/serokell-core";
      sha256 = "1y7wx8yn122rxf1m8nq6qy90ky7yfw8mq30bcl8kfnvqi27f2h39";
      rev = "7ca1ea6b4e426d35652fc4e2b89c3fa864d7ac8f";
    };
    libraryHaskellDepends = with hspkgs; [
      acid-state aeson aeson-extra base base16-bytestring
      base64-bytestring binary binary-orphans bytestring cereal
      cereal-vector clock containers data-msgpack deepseq directory
      either exceptions extra filepath formatting hashable lens mtl
      optparse-applicative parsec QuickCheck quickcheck-instances
      safecopy scientific semigroups template-haskell text text-format
      time-units transformers unordered-containers vector yaml
    ];
    testHaskellDepends = with hspkgs; [
      aeson base binary bytestring cereal data-msgpack hspec QuickCheck
      quickcheck-instances safecopy scientific text text-format
      unordered-containers vector
    ];
    homepage = "http://gitlab.serokell.io/serokell-team/serokell-core";
    description = "General-purpose functions by Serokell";
    license = stdenv.lib.licenses.mit;
  };

  acid-state = hspkgs.mkDerivation {
    pname = "acid-state";
    version = "0.14.2";
    src = fetchgit {
      url = "https://github.com/serokell/acid-state";
      sha256 = "1d9wig3ziwz2rm4j3yqp3kajim1dxxlp7b16vz1r9cyz6k5hds0n";
      rev = "dea606c78d9ecd22247e3c90dcf12c6b4b0458fc";
    };
    libraryHaskellDepends = with hspkgs; [
      array base bytestring cereal containers directory
      extensible-exceptions filepath mtl network safecopy stm
      template-haskell th-expand-syns unix
    ];
    homepage = "http://acid-state.seize.it/";
    description = "Add ACID guarantees to any serializable Haskell data structure";
    license = stdenv.lib.licenses.publicDomain;
  };

  time-warp = hspkgs.mkDerivation {
    pname = "time-warp";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/serokell/time-warp";
      sha256 = "09f1xmg27b44pqv64x3idmx1c5yx33lh0h8mr7k4y2kf0swd5lwd";
      rev = "a011b70eeff425fd962173eef533500739ae6aa7";
    };
    isLibrary = true;
    isExecutable = true;
    doCheck = false;
    libraryHaskellDepends = with hspkgs; [
      ansi-terminal base binary binary-conduit bytestring conduit
      conduit-extra containers data-default data-msgpack deepseq
      exceptions formatting hslogger lens lifted-base monad-control
      monad-loops MonadRandom mtl network pqueue QuickCheck
      quickcheck-instances random safe semigroups serokell-core
      slave-thread stm streaming-commons template-haskell text
      text-format time time-units transformers transformers-base
    ];
    executableHaskellDepends = with hspkgs; [
      async base binary data-default data-msgpack exceptions formatting
      hspec lens MonadRandom mtl QuickCheck random serokell-core stm text
      text-format time-units transformers
    ];
    testHaskellDepends = with hspkgs; [
      async base data-default data-msgpack exceptions hspec lens mtl
      QuickCheck random serokell-core stm text text-format time-units
      transformers
    ];
    homepage = "http://gitlab.serokell.io/serokell-team/time-warp";
    description = "distributed systems execution emulation";
    license = stdenv.lib.licenses.gpl3;
  };

  cryptonite-openssl = hspkgs.mkDerivation {
    pname = "cryptonite-openssl";
    version = "0.2";
    src = fetchgit {
      url = "https://github.com/haskell-crypto/cryptonite-openssl";
      sha256 = "0gkx0hhi77lp02r5bszw7li0qdkz9dzgk48ba5f0099jzqyn79hi";
      rev = "34f17904e658099ac139b35c7a247863f6fdf9f1";
    };
    libraryHaskellDepends = with hspkgs; [ base bytestring memory ];
    librarySystemDepends = with hspkgs; [ openssl ];
    testHaskellDepends = with hspkgs; [
      base bytestring cryptonite tasty tasty-hunit tasty-kat
      tasty-quickcheck
    ];
    doCheck = false;
    homepage = "https://github.com/haskell-crypto/cryptonite-openssl";
    description = "Crypto stuff using OpenSSL cryptographic library";
    license = stdenv.lib.licenses.bsd3;
  };

#  msgpackGIT = pkgs.fetchgit {
#    url = "https://github.com/serokell/msgpack-haskell.git";
#    rev = "c84c868a37446ee0671b3c641a6155af142e6d78";
#    sha256 = "17ikw3fp1mnq9lbw439sgc3msq5dpxhyan70g9iywy5vs11pdrm0";
#  };
#
#  msgpack = hspkgs.mkDerivation {
#    pname = "msgpack";
#    version = "1.0.0";
#    src = msgpackGIT;
#    isLibrary = true;
#    isExecutable = true;
#    doCheck = false;
#
#    # HACK best workaround ever
#    patchPhase = ''
#      mv msgpack .msgpack
#      rm -Rf *
#      mv .msgpack/* .
#    '';
#
#    libraryHaskellDepends = with hspkgs; [
#      base mtl bytestring text containers unordered-containers hashable vector
#      blaze-builder deepseq binary data-binary-ieee754
#      semigroups
#    ];
#    license = pkgs.stdenv.lib.licenses.gpl3;
#  };
#
#  msgpack-rpc = hspkgs.mkDerivation {
#    pname = "msgpack-rpc";
#    version = "1.0.0";
#    src = msgpackGIT;
#    isLibrary = true;
#    isExecutable = true;
#    doCheck = false;
#
#    # HACK best workaround ever
#    patchPhase = ''
#      mv msgpack-rpc .msgpack-rpc
#      rm -Rf *
#      mv .msgpack-rpc/* .
#    '';
#
#    libraryHaskellDepends = with hspkgs; [
#       msgpack base bytestring text network random mtl monad-control 
#       conduit conduit-extra binary-conduit exceptions binary
#    ];
#
#    license = pkgs.stdenv.lib.licenses.gpl3;
#  };

  pvss-haskell = hspkgs.mkDerivation { 
    pname = "pvss";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/input-output-hk/pvss-haskell";
      sha256 = "0nzqj2ysj045ik8a2p4vnhldamlgxj2hriqcrx4rfr85qpxak6br";
      rev = "996951c97f97d734ec7cea05e72620eaabfc72f3";
    };
    isLibrary = true;
    isExecutable = true;
    libraryHaskellDepends = with hspkgs; [
      base binary bytestring cryptonite cryptonite-openssl deepseq
      integer-gmp memory
    ];
    executableHaskellDepends = with hspkgs; [
      base cryptonite deepseq hourglass memory
    ];
    testHaskellDepends = with hspkgs; [ base cryptonite tasty tasty-quickcheck ];
    homepage = "https://github.com/githubuser/pvss#readme";
    description = "Public Verifiable Secret Sharing";
    license = stdenv.lib.licenses.bsd3;
  };
 
  kademlia = hspkgs.mkDerivation {
    pname = "kademlia";
    version = "1.1.0.0";
    src = fetchgit {
      url = "https://github.com/serokell/kademlia";
      sha256 = "0p0ww5qq5bxfrrhrx3pi5pg62m5nz0am5jqr19gbz78vdc06zk6w";
      rev = "d3d6d62fc248156320ec92c730a38f483500edd5";
    };

    doCheck = false;
    libraryHaskellDepends = with hspkgs; [
      base bytestring containers mtl network stm transformers
      transformers-compat
    ];
    testHaskellDepends = with hspkgs; [
      base bytestring containers HUnit mtl network QuickCheck stm tasty
      tasty-hunit tasty-quickcheck transformers transformers-compat
    ];
    homepage = "https://github.com/froozen/kademlia";
    description = "An implementation of the Kademlia DHT Protocol";
    license = stdenv.lib.licenses.bsd3;
  };

  cardano = hspkgs.mkDerivation {
    pname = "pos";
    version = "0.1.0.0";
    src = fetchgit {
      url = "https://github.com/input-output-hk/pos-haskell-prototype";
      sha256 = "0qsbg6p36drj5n8j0nlff31k5xi6n8k425swmdhf5x7fya0g62ms";
      rev = "4b1538c44345120898a75b6a10e575556a52f1ea";
    };
    isLibrary = true;
    isExecutable = true;
    doCheck = true;
    doHaddock = false;
    libraryHaskellDepends = with hspkgs; [
      acid-state async base binary binary-orphans bytestring cereal
      containers cryptonite data-default data-msgpack derive ed25519
      exceptions formatting hashable HsOpenSSL kademlia lens lrucache
      memory mtl parsec pvss QuickCheck quickcheck-instances random
      safecopy serokell-core stm template-haskell text text-format time
      time-warp transformers universum unordered-containers vector
    ];
    executableHaskellDepends = with hspkgs; [
      async base binary bytestring data-default directory filepath
      formatting optparse-applicative optparse-simple parsec
      serokell-core time-warp universum
    ];
    testHaskellDepends = with hspkgs; [
      base binary bytestring cryptonite formatting hspec memory
      QuickCheck random serokell-core time-units time-warp universum
      unordered-containers
    ];
    description = "Proof-of-stake";
    license = stdenv.lib.licenses.bsd3;
  };
  
  hspkgs = pkgs.haskell.packages.ghc801.override {
    overrides = self: super: {
      inherit serokell-core;
      inherit acid-state;
      inherit time-warp;
      inherit universum;
      inherit kademlia; 
      inherit cardano;
      inherit cryptonite-openssl;
#      inherit msgpack;
#      inherit msgpack-rpc;
      pvss = pvss-haskell;
    };
  };

}

