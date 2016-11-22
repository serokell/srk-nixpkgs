{ mkDerivation, aeson, ansi-terminal, bytestring, data-default
, directory, errors, extra, exceptions, fetchgit, filepath, hashable, hslogger
, lens, monad-control, mtl, serokell-util
, stdenv, text, transformers, transformers-base, unordered-containers, yaml
}:
mkDerivation {
  pname = "log-warper";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/serokell/log-warper/";
    sha256 = "0929yagw46vnnxf1dhaxggd84js2jnm2bfk4jxcm8xhgmyriwzsv";
    rev = "5de577c3ab25e6f9a4350a9646050a88b2b8996e";
  };

  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-terminal base bytestring
    data-default directory errors exceptions extra
    filepath hashable hslogger lens
    monad-control mtl
    serokell-util
    text transformers
    transformers-base unordered-containers yaml
  ];
  executableHaskellDepends = [
    base exceptions hslogger
  ];
  homepage = "http://gitlab.serokell.io/serokell-team/log-warper";
  description = "Monad for logging";
  license = stdenv.lib.licenses.gpl3;
}
