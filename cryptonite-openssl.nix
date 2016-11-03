{ mkDerivation, base, bytestring, cryptonite, fetchgit, memory
, openssl, stdenv, tasty, tasty-hunit, tasty-kat, tasty-quickcheck
}:
mkDerivation {
  pname = "cryptonite-openssl";
  version = "0.2";
  src = fetchgit {
    url = "https://github.com/haskell-crypto/cryptonite-openssl";
    sha256 = "1s129bpvbvr6wybfn47fzbxpkrj33gqn6azs41ff0j7pirpd3xv8";
    rev = "bf8ffeb9534538f71a5430bc5b9e9ba00e72683f";
  };
  libraryHaskellDepends = [ base bytestring memory ];
  librarySystemDepends = [ openssl ];
  testHaskellDepends = [
    base bytestring cryptonite tasty tasty-hunit tasty-kat
    tasty-quickcheck
  ];
  homepage = "https://github.com/haskell-crypto/cryptonite-openssl";
  description = "Crypto stuff using OpenSSL cryptographic library";
  license = stdenv.lib.licenses.bsd3;
}
