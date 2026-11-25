{
  description = "Quickshell dynamic-island bar — QML plus the NixOS/home-manager modules that wire it up, imported as a flake input by nix-refactor.";

  outputs =
    { self, ... }:
    {
      nixosModules.default = import ./nix/nixos.nix;
      homeManagerModules.default = import ./nix/home-manager.nix { inherit self; };
    };
}
