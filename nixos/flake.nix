{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... } @ inputs : let system = "x86_64-linux"; in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; inherit system; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
