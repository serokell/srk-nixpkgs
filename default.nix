{ pkgs ? (import <nixpkgs> {})
, compiler ? pkgs.haskell.packages.ghc801
, genesisN ? 3 
, slotDuration ? 20 
, networkDiameter ? 6
, mpcRelayInterval ? 16 } :

with pkgs; 

let
  overrideAttrs = package: newAttrs:
    package.override (args: args // {
      mkDerivation = expr: args.mkDerivation (expr // newAttrs);
    });

  # Autogenerate default.nix from cabal file in src
  haskellPackageGen = { doHaddock ? false, doFilter ? false }: src:
     let filteredSrc = builtins.filterSource (n: t: t != "unknown") src;
         package = pkgs.runCommand "default.nix" {} ''
           ${compiler.cabal2nix}/bin/cabal2nix \
             ${if doFilter then filteredSrc else src} \
             ${if doHaddock
                 then ""
                 else "--no-haddock"} \
             > $out
         '';
     in import package;
  kademliaTW = fetchFromGitHub {
    owner = "serokell";
    repo = "kademlia";
    rev = "7a0bdfe8bba2503ab96bddd9021ba36e50e5ccc2";
    sha256 = "05bg2wf9nvhh0xwb2p5camnkvzaiyav8jh0l53d5wh53y4jmd6sy";
  };
in rec {
  universum = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "universum";
        rev = "d347ccf3605d0851dd0f7046fe63f364510ef1a0";
        sha256 = "07zbqp2cgzp3795f3z9jmgd700ccqvgj18pc2d95q7q7cc88fix0";
      })
  ) { };
  acid-state = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "acid-state";
        rev = "95fce1dbada62020a0b2d6aa2dd7e88eadd7214b";
        sha256 = "109liqzk66cxkarw8r8jxh27n6qzdcha2xlhsj56xzyqc2aqjz15";
      })
  ) { };
  log-warper = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "log-warper";
        rev = "8b1f81014383e9b21c8378e6c2ab388d32463d87";
        sha256 = "01fwlbf4v9icnggam65c8bbymjs6whi7m026gzhf0287kl7l88cg";
      })
  ) { };
  tw-rework-sketch = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "tw-rework-sketch";
        rev = "152625804ebb8c38033ae92228fb3ddbe5955e76";
        sha256 = "1zb74ba0m60iarc90i1hj7vqivlfqy6nwlw73kp5zhzn8xi2zryb";
      })
  ) { kademlia = hspkgs.callPackage (haskellPackageGen {} kademliaTW) {}; };
  plutus-prototype = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "input-output-hk";
        repo = "plutus-prototype";
        rev = "aa6d535cf47fe92aabfbdb8bb709f5cba52ab793";
        sha256 = "0blmkgvd40i8md8wgq41cfh9gs39x0hmfz1513qzjndwkahw3g8q";
      })
  ) { };
  rocksdb-haskell = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "rocksdb-haskell";
        rev = "5c17f60dad1fd91d47f05cd8b02e859aa26a3547";
        sha256 = "0bqh20bxv0wgcc4qijc08mq0nwpj4b8cb3l8f7wl4714970b2jj7";
      })
  ) { };
  kademlia = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "kademlia";
        rev = "278171b8ab104c78aa95bcdd9b63c8ced4fb1ed2";
        sha256 = "0p23v8qlqrfvsiycdlacx8y3hksnrjfjln3wfqcnlrk8dz4fd5cv";
      })
  ) { };
  hs-ed25519 = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "domenkozar";
        repo = "hs-ed25519";
        rev = "96e5db162d88482bc0e120dc61cadd45c168c275";
        sha256 = "10y7qfxwc0zi3v3p4jcqfdkg5z9l8fy8vxv06h60b8n3di649r4s";
      })
  ) { };
  pvss = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "input-output-hk";
        repo = "pvss-haskell";
        rev = "42751055d1794627ac53b6404373dfc7b44a8366";
        sha256 = "1cna6wxpgb4sy7wvfkmf6y7jkk8bjybj85zdxl2zr0bnzg0qil8s";
      })
  ) { };
  serokell-util = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "serokell-util";
        rev = "c37625cc4daaa6b312e53d47200ded78cbbd0659";
        sha256 = "0zfrznxhzhbxcbxg46w4fbzv78if3i62r4zlhmfimrlhk5gc9a5p";
      })
  ) { };
  time-warp = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "time-warp";
        rev = "4d5c82fc05f5c01919980e28e64de3753e317546";
        sha256 = "18ijrb3ghjw17r7ng34r5w2acbni010x13p199lmz25vrpsilqzb";
      })
  ) { };
  cardano-sl = hspkgs.callPackage ./cardano-sl.nix { inherit genesisN slotDuration networkDiameter mpcRelayInterval; };
  
  hspkgs = compiler.override {
    overrides = self: super: {
      inherit cardano-sl;
      inherit universum acid-state log-warper kademlia plutus-prototype rocksdb-haskell hs-ed25519 pvss serokell-util time-warp;
      th-expand-syns = overrideAttrs super.th-expand-syns {
        version = "0.4.1.0";
        sha256 = "1sj8psxnmjsxrfan2ryx8w40xlgc1p51m7r0jzd49mjwrj9gb661";
      };
      network-transport-inmemory = overrideAttrs super.network-transport-inmemory {
        version = "0.5.2";
        sha256 = "0kpgx6r60cczr178ras5ia9xiihrs5a9hnfyv45djmq16faxfic2";
      };
      cryptonite-openssl = overrideAttrs super.cryptonite-openssl {
        version = "0.3";
        sha256 = "09pfpll3hxx49cbr0a1h1pk5602sql2gcd4783j3n44z4nsgij23";
      };
      mkDerivation = args: super.mkDerivation (args // {
        enableLibraryProfiling = true;
      });
    };
  };

}

