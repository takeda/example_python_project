{ sources ? import ./sources.nix }:
import sources.nixpkgs {
  overlays = [
    (_: pkgs: { inherit sources; })
    (_: pkgs: { niv = (import sources.niv { inherit pkgs; }).niv; })
    (_: pkgs: { pip2nix = import sources.pip2nix { inherit pkgs; pythonPackages = "python38Packages"; }; })
  ];
  config = {};
}
