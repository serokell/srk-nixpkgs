{ pkgs, compiler ? pkgs.haskell.packages.ghc801 } :

with pkgs; rec {

  universum = hspkgs.callPackage ./universum.nix { };
  serokell-core = hspkgs.callPackage ./serokell-core.nix { };
  acid-state = hspkgs.callPackage ./acid-state.nix { };
  time-warp = hspkgs.callPackage ./time-warp.nix { };
  cryptonite-openssl = hspkgs.callPackage ./cryptonite-openssl.nix { };
  pvss = hspkgs.callPackage ./pvss.nix { };
  kademlia = hspkgs.callPackage ./kademlia.nix { };
  cardano-sl = hspkgs.callPackage ./cardano-sl.nix { };
  
  hspkgs = compiler.override {
    overrides = self: super: {
      inherit universum;
      inherit serokell-core;
      inherit acid-state;
      inherit time-warp;
      inherit cryptonite-openssl;
      inherit pvss;
      inherit kademlia; 
      inherit cardano-sl;
    };
  };

}

