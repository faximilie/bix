{
  description = "";

  inputs = {
    nixpkgs =  {
    	url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager =  {
    	url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        doomdir.url = "github:faximilie/quakemacs/doom-emacs-unstraightened";
      };
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, nix-doom-emacs-unstraightened, ... }:
    {
      nixosConfigurations.fred-nerk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules =  with inputs; [
          # (inputs.import-tree ./mods)
          ./mods/default.nix
          ./mods/hardware.nix
          ./mods/security
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.faxy = { pkgs, ... }: {
                imports = [ ./home.nix
                            inputs.nix-doom-emacs-unstraightened.homeModule
                          ];
              };
            };
          }
        ];
      };
      homeConfigurations."faxy" = inputs.home-manager.lib.homeMangerConfiguration {
        home-manager.extraSpecialArgs = {inherit inputs;}; 
        modules = with inputs; [
          ./home.nix
        ];
      };
    };
}
