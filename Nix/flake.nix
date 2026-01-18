{
  description = "Giyu's Secure NixOS configuration with Hyprland";

  inputs = {
    # Main package repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Hyprland compositor (built from source with submodules)
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    
    # Secure Boot support via Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";  # Use same nixpkgs version
    };
  };

  outputs = { self, nixpkgs, hyprland, lanzaboote, ... }@inputs: {
    # System configuration for hostname "nixos"
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass inputs to modules so they can access hyprland, lanzaboote
      specialArgs = { inherit inputs; };
      
      # Load configuration files
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
