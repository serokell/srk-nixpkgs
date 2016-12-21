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
  universum = hspkgs.callPackage ./universum.nix { };
  serokell-util = hspkgs.callPackage ./serokell-util.nix { };
  acid-state = hspkgs.callPackage ./acid-state.nix { };
  log-warper = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "log-warper";
        rev = "14d0d2f391e2ebb6a9679f1dd117c325aff53637";
        sha256 = "12zb8ww7f4dh0q1mp5l8kjk4hxj80da0b4wpzsn7nrzry6xk6jxl";
      })
  ) { };
  time-warp = hspkgs.callPackage ./time-warp.nix { };
  tw-rework-sketch = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "tw-rework-sketch";
        rev = "36bf0e0ba637f1934f641fd0a1c38ae3c066af6b";
        sha256 = "1ayz2ja31v9qgi39ccy1i3pj1hq0x47q8nzqcfb221b3mcbnvq00";
      })
  ) { kademlia = hspkgs.callPackage (haskellPackageGen {} kademliaTW) {}; };
  cryptonite-openssl = hspkgs.callPackage ./cryptonite-openssl.nix { };
  plutus-prototype = hspkgs.callPackage ./plutus-prototype.nix { };
  rocksdb-haskell = hspkgs.callPackage ./rocksdb-haskell.nix { };
  pvss = hspkgs.callPackage ./pvss.nix { };
  kademlia = hspkgs.callPackage ./kademlia.nix { };
  cardano-sl = hspkgs.callPackage ./cardano-sl.nix { inherit genesisN slotDuration networkDiameter mpcRelayInterval; };
  
  hspkgs = compiler.override {
    overrides = self: super: {
      inherit universum;
      inherit serokell-util;
      inherit acid-state;
      inherit log-warper;
      inherit time-warp;
      #inherit cryptonite-openssl;
      inherit pvss;
      inherit kademlia; 
      inherit cardano-sl;
      inherit plutus-prototype rocksdb-haskell;
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

