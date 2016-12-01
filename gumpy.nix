with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "gumby";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    python27
    python27Packages.twisted
    python27Packages.psutil
    python27Packages.configobj
    python27Packages.cryptography
    R
  ];
}
