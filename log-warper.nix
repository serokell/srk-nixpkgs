{ mkDerivation, aeson, ansi-terminal, base, bytestring, data-default
, directory, errors, extra, exceptions, fetchgit, filepath, formatting, hashable, hslogger
, lens, monad-control, mtl, serokell-util
, stdenv, text, transformers, transformers-base, unordered-containers, yaml
}:
mkDerivation {
  pname = "log-warper";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/serokell/log-warper/";
    sha256 = "0fa4zbcnkgk4kpa8w8pa2rkkd4nmlw4radp12flk58xyzvccgy3x";
    rev = "3bd88e1b141745a97748351cbe43cdc8578338eb";
  };

  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-terminal base bytestring
    data-default directory errors exceptions extra
    filepath formatting hashable hslogger lens
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
