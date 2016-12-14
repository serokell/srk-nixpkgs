{ mkDerivation, base, binary, bytestring, data-default, fetchgit
, filepath, resourcet, rocksdb, stdenv, transformers
}:
mkDerivation {
  pname = "rocksdb";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/serokell/rocksdb-haskell.git";
    sha256 = "1dpf2ys66win6hv66h38xvm910wf4qk91hf38d4pakvacjqdfzx1";
    rev = "0a5bced2c0372e5d0dff886595841406cf6a73a2";
  };
  libraryHaskellDepends = [
    base binary bytestring data-default filepath resourcet transformers
  ];
  librarySystemDepends = [ rocksdb ];
  homepage = "http://github.com/serokell/rocksdb-haskell";
  description = "Haskell bindings to RocksDB";
  license = stdenv.lib.licenses.bsd3;
}
