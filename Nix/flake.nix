{
  description = "NixOS configuration with Hyprland";
  inputs = {
    # Main package repository — tracking unstable, which is why
    # stateVersion in configuration.nix doesn't need bumping just
    # because a stable release (25.11) went EOL.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hyprland compositor (built from source, tracks upstream main).
    # Consider adding `inputs.nixpkgs.follows = "nixpkgs";` here if you
    # start seeing weird dependency conflicts between this Hyprland build
    # and the rest of your system — it forces Hyprland to build against
    # the same nixpkgs revision instead of pulling its own pinned copy,
    # which usually means faster/more cache-hittable builds.
    hyprland.url = "github:hyprwm/Hyprland";

    # Secure Boot support via Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs"; # Use same nixpkgs version
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

