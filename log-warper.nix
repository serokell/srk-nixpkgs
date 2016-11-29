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
    sha256 = "00k8sia0wfiv8vp9lg0axd7plcfrd27dvp5q2lx4vczqsjjgnxpg";
    rev = "d3b5f518e2827a961ba884a8009d4cfd4ccc737b";
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
