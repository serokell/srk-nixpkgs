{ mkDerivation, base, binary, bytestring, cryptonite
, cryptonite-openssl, deepseq, fetchgit, hourglass, integer-gmp
, memory, stdenv, tasty, tasty-quickcheck
}:
mkDerivation {
  pname = "pvss";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/input-output-hk/pvss-haskell";
    sha256 = "0svfvw459dwnpin3vvn1ys007zpg3vgss473c3jbzfilc57zl1cc";
    rev = "1b898a222341116d210f2d3a5566028e14a335ae";
  };
  isLibrary = true;
  isExecutable = true;
  doCheck = false;
  libraryHaskellDepends = [
    base binary bytestring cryptonite cryptonite-openssl deepseq
    integer-gmp memory
  ];
  executableHaskellDepends = [
    base cryptonite deepseq hourglass memory
  ];
  testHaskellDepends = [ base cryptonite tasty tasty-quickcheck ];
  homepage = "https://github.com/githubuser/pvss#readme";
  description = "Public Verifiable Secret Sharing";
  license = stdenv.lib.licenses.bsd3;
}
