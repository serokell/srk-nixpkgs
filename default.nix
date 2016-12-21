{ pkgs ? (import <nixpkgs> {})
, compiler ? pkgs.haskell.packages.ghc801
, genesisN ? 3 
, slotDuration ? 20 
, networkDiameter ? 6
, mpcRelayInterval ? 16 } :


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
in with pkgs; rec {
  universum = hspkgs.callPackage ./universum.nix { };
  serokell-util = hspkgs.callPackage ./serokell-util.nix { };
  acid-state = hspkgs.callPackage ./acid-state.nix { };
  log-warper = hspkgs.callPackage ./log-warper.nix { };
  time-warp = hspkgs.callPackage ./time-warp.nix { };
  tw-rework-sketch = hspkgs.callPackage (
    haskellPackageGen {} (fetchFromGitHub {
        owner = "serokell";
        repo = "tw-rework-sketch";
        rev = "e0e865b3fc7cbfeb0b6cf560fe1357ceb997efd8";
        sha256 = "1frvcz195k9fnc7pgy9zbwbjf4vv9ml2x37xy94m1s8b68y2ld22";
      })
  ) {};
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

