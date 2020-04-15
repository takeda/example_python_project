let
  pkgs = import ./nix {};
  app = import ./default.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = [
    app
    pkgs.niv
    pkgs.pip2nix
    pkgs.python38Packages.pip-tools
  ];
}
