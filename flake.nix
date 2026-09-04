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
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      homeModules = [
        ./homeModules/desktop/sway.nix
        ./homeModules/editor/emacs.nix
        ./homeModules/editor/neovim.nix
        ./homeModules/faxy.nix
        ./homeModules/shared.nix
        nix-doom-emacs-unstraightened.homeModule
      ];
      jakeLong = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/jake-long.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.faxy.imports = homeModules;
            };
          }
        ];
      };
      faxy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = homeModules;
      };
    in {
      nixosConfigurations = {
        jake-long = jakeLong;
        fred-nerk = jakeLong;
      };
      homeConfigurations.faxy = faxy;
      checks.${system} = {
        nixos-jake-long = jakeLong.config.system.build.toplevel;
        home-faxy = faxy.activationPackage;
      };
    };
}
