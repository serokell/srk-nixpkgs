{ mkDerivation, aeson, ansi-terminal, base, bytestring, data-default
, directory, errors, extra, exceptions, fetchgit, filepath, formatting, hashable, hslogger
, lens, monad-control, mtl, serokell-util, safecopy
, stdenv, text, transformers, transformers-base, unordered-containers, yaml
}:
mkDerivation {
  pname = "log-warper";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/serokell/log-warper/";
    sha256 = "0s5kplzxfycb1aa9d09vwks1bqwhv56si3c5i5rbyjv9pj4jjg0b";
    rev = "409055f388e321aa3a9c97cd66215aad2c414adb";
  };

  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-terminal base bytestring
    data-default directory errors exceptions extra
    filepath formatting hashable hslogger lens
    monad-control mtl
    serokell-util safecopy
    text transformers
    transformers-base unordered-containers yaml
  ];
  executableHaskellDepends = [
    base exceptions hslogger safecopy
  ];
  homepage = "http://gitlab.serokell.io/serokell-team/log-warper";
  description = "Monad for logging";
  license = stdenv.lib.licenses.gpl3;
}
