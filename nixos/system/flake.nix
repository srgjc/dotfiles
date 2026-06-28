{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { nixpkgs, zen-browser, ... } @ inputs : let system = "x86_64-linux"; in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; inherit system; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
