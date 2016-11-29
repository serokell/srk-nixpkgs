{ mkDerivation, base, binary, bytestring, cryptonite
, cryptonite-openssl, deepseq, fetchgit, hourglass, integer-gmp
, memory, stdenv, tasty, tasty-quickcheck
}:
mkDerivation {
  pname = "pvss";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/input-output-hk/pvss-haskell";
    sha256 = "1cna6wxpgb4sy7wvfkmf6y7jkk8bjybj85zdxl2zr0bnzg0qil8s";
    rev = "42751055d1794627ac53b6404373dfc7b44a8366";
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
