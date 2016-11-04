{ pkgs, compiler ? pkgs.haskell.packages.ghc801, genesisN ? 3 } :

with pkgs; rec {

  universum = hspkgs.callPackage ./universum.nix { };
  serokell-util = hspkgs.callPackage ./serokell-util.nix { };
  acid-state = hspkgs.callPackage ./acid-state.nix { };
  time-warp = hspkgs.callPackage ./time-warp.nix { };
  cryptonite-openssl = hspkgs.callPackage ./cryptonite-openssl.nix { };
  pvss = hspkgs.callPackage ./pvss.nix { };
  kademlia = hspkgs.callPackage ./kademlia.nix { };
  cardano-sl = hspkgs.callPackage ./cardano-sl.nix { inherit genesisN;};
  
  hspkgs = compiler.override {
    overrides = self: super: {
      inherit universum;
      inherit serokell-util;
      inherit acid-state;
      inherit time-warp;
      inherit cryptonite-openssl;
      inherit pvss;
      inherit kademlia; 
      inherit cardano-sl;
    };
  };

}

