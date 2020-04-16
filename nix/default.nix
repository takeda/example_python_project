{ sources ? import ./sources.nix }:
import sources.nixpkgs {
  overlays = [
    (self: super: {
      inherit sources;
      inherit (import sources.gitignore { inherit (super) lib; }) gitignoreSource;
      inherit (import sources.niv { pkgs = super; }) niv;
      pip2nix = import sources.pip2nix { pkgs = super; pythonPackages = "python38Packages"; };
    })
  ];
}
