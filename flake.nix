{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Dotfiles
    dotfiles = {
      url = "github:pyrsson/dotfiles";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      # forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: _prev: { unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; }; })
          ];
        }
      );
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nix-vm = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./machines/vm ];
        };
        sidearm = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./machines/home ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "simon@nix-vm" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/work.nix ];
        };
        "simon@sidearm" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/home.nix ];
        };
        "simon@thinkpad-x1" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/work.nix ];
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
