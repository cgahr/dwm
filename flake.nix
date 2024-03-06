{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      packages.x86_64-linux.dwm = pkgs.dwm.overrideAttrs
        (old: {
          src = ./.;
          buildInputs = old.buildInputs ++ (
            with pkgs; [
              pulseaudio
              playerctl
            ]
          );
        })
      ;
      packages.x86_64-linux.default = self.packages.x86_64-linux.dwm;
    };
}
