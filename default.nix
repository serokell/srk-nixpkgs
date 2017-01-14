{ pkgs ? (import <nixpkgs> {})
, compiler ? pkgs.haskell.packages.ghc801
, genesisN ? 3 
, slotDuration ? 20 
, networkDiameter ? 6
, mpcRelayInterval ? 16 } :

with pkgs; 
with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs;});

let
  overrideAttrs = package: newAttrs:
    package.override (args: args // {
      mkDerivation = expr: args.mkDerivation (expr // newAttrs);
    });

  # Autogenerate default.nix from cabal file in src
  haskellPackageGen = { doHaddock ? false, doFilter ? false, doCheck ? true, profiling ? false }: src:
     let filteredSrc = builtins.filterSource (n: t: t != "unknown") src;
         package = pkgs.runCommand "default.nix" {} ''
           ${compiler.cabal2nix}/bin/cabal2nix \
             ${if doFilter then filteredSrc else src} \
             ${if doHaddock
                 then ""
                 else "--no-haddock"} \
             ${if doCheck
                 then ""
                 else "--no-check"} \
             ${if profiling
                 then "--enable-profiling"
                 else ""} \
             > $out
         '';
     in import package;
  kademliaTW = fetchFromGitHub {
    owner = "serokell";
    repo = "kademlia";
    rev = "8ebc91484994fbd1b8383d42786ae40bb5c99042";
    sha256 = "0wlfb79xr2z8pd8pkzyz806kbh385b7gcx1s9h3jg46mq4ffi1y7";
  };
in rec {
  universum = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "universum";
        rev = "db3cd301545e5da000e53ca2cdf274e0386192bf";
        sha256 = "1il4z2kkkgp201h8b9j4li123llca98wr79pg4dpk2g9kjcrmkf9";
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
        rev = "e05d74587ff9270891a3e57f1f15d9e91c8d2c83";
        sha256 = "19f0b2gi9h9ja9jp7na1l926ciy47gvi65gmjh9vkkswkh2ipwg7";
      })
  ) { };
  network-transport-tcp = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "network-transport-tcp";
        rev = "586c9bf830252476522cab6274ef8ddc32615686";
        sha256 = "04q73wpi5kzqr4fk1zm5bgayljjc62qi34yls59zwv73k745dwzp";
      })
  ) { };
  tw-rework-sketch = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "tw-rework-sketch";
        rev = "8d4773a6a03b9b1d676115ba4bf6a5021bc184c9";
        sha256 = "0ny0pmkbcinfizbf9q3vlvpscq10h59b492rnf0xmsyh5fy11aw7";
      })
  ) { };
  plutus-prototype = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "input-output-hk";
        repo = "plutus-prototype";
        rev = "62b4aaf5e8dfe70a7734a555032d8461ce4a812a";
        sha256 = "02av2vvdffpcm0y7df3mi1jr76vpm6cj3cz3hjv4x172chxkzg2c";
      })
  ) { };
  rocksdb-haskell = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "rocksdb-haskell";
        rev = "cbe733d9bbdc61b07d9a6fd0bc7964ac1e78f6a5";
        sha256 = "0hi5fda4h8q1jrdr6k0knxhzs08lhwc5a7achj0ys75snh7w5151";
      })
  ) { };
  kademlia = hspkgs.callPackage (
    haskellPackageGen { doCheck = false; } (fetchFromGitHub {
        owner = "serokell";
        repo = "kademlia";
        rev = "8ebc91484994fbd1b8383d42786ae40bb5c99042";
        sha256 = "0wlfb79xr2z8pd8pkzyz806kbh385b7gcx1s9h3jg46mq4ffi1y7";
      })
  ) { };
  ed25519 = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "domenkozar";
        repo = "hs-ed25519";
        rev = "96e5db162d88482bc0e120dc61cadd45c168c275";
        sha256 = "1d3rry1lycdk4dq9ivhzlb5ygpr009ahfj07dsy3cigshy8r0llz";
      })
  ) { };
  pvss = hspkgs.callPackage (
    haskellPackageGen { doCheck = false; } (fetchFromGitHub {
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
    haskellPackageGen { profiling = false; } (fetchFromGitHub {
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
      inherit universum acid-state log-warper kademlia plutus-prototype rocksdb-haskell ed25519 pvss serokell-util time-warp tw-rework-sketch network-transport-tcp;
      QuickCheck = super.QuickCheck_2_9_2;
      th-expand-syns = overrideAttrs super.th-expand-syns {
        version = "0.4.1.0";
        sha256 = "1sj8psxnmjsxrfan2ryx8w40xlgc1p51m7r0jzd49mjwrj9gb661";
      };
      network-transport-inmemory = overrideAttrs super.network-transport-inmemory {
        version = "0.5.2";
        sha256 = "0kpgx6r60cczr178ras5ia9xiihrs5a9hnfyv45djmq16faxfic2";
      };
      cryptonite-openssl = overrideAttrs (overrideCabal super.cryptonite-openssl (drv: { libraryHaskellDepends = drv.libraryHaskellDepends ++ [super.cryptonite];})) {
        version = "0.3";
        sha256 = "09pfpll3hxx49cbr0a1h1pk5602sql2gcd4783j3n44z4nsgij23";
      };
      mkDerivation = args: super.mkDerivation (args // {
        enableLibraryProfiling = false;
        # Remove after hspec-expectations-pretty-diff-0.7.2.4 tests fixed (nneded for purescript-bridge)
        doCheck = false;
      });
    };
  };

}

