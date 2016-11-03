{ mkDerivation, base, bytestring, cryptonite, fetchgit, memory
, openssl, stdenv, tasty, tasty-hunit, tasty-kat, tasty-quickcheck
}:
mkDerivation {
  pname = "cryptonite-openssl";
  version = "0.2";
  src = fetchgit {
    url = "https://github.com/haskell-crypto/cryptonite-openssl";
    sha256 = "0gkx0hhi77lp02r5bszw7li0qdkz9dzgk48ba5f0099jzqyn79hi";
    rev = "34f17904e658099ac139b35c7a247863f6fdf9f1";
  };
  libraryHaskellDepends = [ base bytestring memory ];
  librarySystemDepends = [ openssl ];
  doCheck = false;
  testHaskellDepends = [
    base bytestring cryptonite tasty tasty-hunit tasty-kat
    tasty-quickcheck
  ];
  homepage = "https://github.com/haskell-crypto/cryptonite-openssl";
  description = "Crypto stuff using OpenSSL cryptographic library";
  license = stdenv.lib.licenses.bsd3;
}
