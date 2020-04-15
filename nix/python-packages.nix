# Generated by pip2nix 0.8.0.dev1
# See https://github.com/nix-community/pip2nix

{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super: {
  "tqdm" = super.buildPythonPackage rec {
    pname = "tqdm";
    version = "4.45.0";
    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/4a/1c/6359be64e8301b84160f6f6f7936bbfaaa5e9a4eab6cbc681db07600b949/tqdm-4.45.0-py2.py3-none-any.whl";
      sha256 = "155ghg31xd48civkw75xlqyq3ipkzb0w9gvm7mwfhdwsppb3z7pa";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
}