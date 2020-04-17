{ pkgs ? import ./nix {}
, pythonPackages ? "python38Packages"
}:

let
  inherit (pkgs.lib) fix extends;

  basePythonPackages = with builtins; if isAttrs pythonPackages
    then pythonPackages
    else getAttr pythonPackages pkgs;

  pythonPackagesGenerated = pkgs.callPackage ./nix/python-packages.nix {};
  pythonPackagesOverrides = pkgs.callPackage ./nix/python-packages-overrides.nix { inherit basePythonPackages; };

  # extract package name, version & dependencies from setup.cfg
  setupcfg = import (pkgs.runCommand "setup.cfg" {} ''${pkgs.setupcfg2nix}/bin/setupcfg2nix ${./setup.cfg} > $out'');

  pythonPackagesLocalOverrides = self: super: {
    hello = super.buildSetupcfg {
      info = setupcfg;
      src = pkgs.gitignoreSource ./.;
      application = true;
    };
  };

  myPythonPackages =
    (fix
    (extends pythonPackagesLocalOverrides
    (extends pythonPackagesOverrides
    (extends pythonPackagesGenerated
             basePythonPackages.__unfix__))));

in myPythonPackages.hello
