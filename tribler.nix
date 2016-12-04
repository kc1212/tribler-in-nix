with import <nixpkgs> {};

let dependencies = rec {
  _leveldb = with python27Packages; buildPythonPackage {
    name = "leveldb-0.194";
    src = fetchurl {
      url = "https://pypi.python.org/packages/ec/c1/ca3b4199bd4073e6430076f1edd8061f2f548e831eeddc3cbc077ebaa0ca/leveldb-0.194.tar.gz";
      sha256 = "9c3378b3b4336cc63303e9fe5d054a337d50bafec80ac4628db19a598c0fcd38";
    };
  };
  _libnacl = with python27Packages; buildPythonPackage {
    name = "libnacl-1.5.0";
    src = fetchurl {
      url = "https://pypi.python.org/packages/b8/59/62b7f0952da7ce6d677c8cc78ef62defe48c99bdf5822ca407b5a5c7008f/libnacl-1.5.0.tar.gz";
      sha256 = "1af2bc9fab80bd264ed224d9c4cacb0514db2f202eca5a4d90da3b06ba2000de";
    };
  };
};
in with dependencies;

stdenv.mkDerivation rec {
  name = "tribler";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    python27
    python27Packages.virtualenv
    python27Packages.pip
    python27Packages.apsw
    python27Packages.cryptography
    python27Packages.feedparser
    python27Packages.m2crypto
    python27Packages.netifaces
    python27Packages.pillow
    python27Packages.pyasn1
    python27Packages.twisted
    python27Packages.chardet
    python27Packages.configobj
    python27Packages.pyqt5
    python27Packages.cherrypy
    python27Packages.decorator
    vlc
    libav
    libsodium
    xorg.libX11
    libtorrentRasterbar # contains python bindings
    _libnacl
    _leveldb

    # packages below are optional, used for testing
    python27Packages.nose
    python27Packages.nose-exclude
  ];
  LD_LIBRARY_PATH="${libsodium}/lib:${vlc}/lib";
}
