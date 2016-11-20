{ pkgs
, compiler ? pkgs.haskell.packages.ghc801
, genesisN ? 3 
, slotDuration ? 20 
, networkDiameter ? 6
, mpcRelayInterval ? 16 } :


let
overrideAttrs = package: newAttrs: package.override (args: args // {
              mkDerivation = expr: args.mkDerivation (expr // newAttrs);
            });
in
with pkgs; rec {

  universum = hspkgs.callPackage ./universum.nix { };
  serokell-util = hspkgs.callPackage ./serokell-util.nix { };
  acid-state = hspkgs.callPackage ./acid-state.nix { };
  log-warper = hspkgs.callPackage ./log-warper.nix { };
  time-warp = hspkgs.callPackage ./time-warp.nix { };
  cryptonite-openssl = hspkgs.callPackage ./cryptonite-openssl.nix { };
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
      inherit cryptonite-openssl;
      inherit pvss;
      inherit kademlia; 
      inherit cardano-sl;
      th-expand-syns = overrideAttrs super.th-expand-syns {
        version = "0.4.1.0";
        sha256 = "1sj8psxnmjsxrfan2ryx8w40xlgc1p51m7r0jzd49mjwrj9gb661";
      };
    };
  };

}

