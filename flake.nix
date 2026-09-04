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

    import-tree.url = "github:denful/import-tree";

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
  outputs = inputs@{ nixpkgs, home-manager, import-tree, nix-doom-emacs-unstraightened, ... }:
    let
      importTree = import-tree.lib.importTree;
    in
    {
      nixosConfigurations.fred-nerk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = with inputs; [
          (importTree ./mods)
          ./pkgs
          ./hosts/fred-nerk
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.faxy = { pkgs, ... }: {
                imports = [
                  ./user/faxy
                  inputs.nix-doom-emacs-unstraightened.homeModule
                ];
              };
            };
          }
        ];
      };
      homeConfigurations."faxy" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = self.nixosConfigurations.fred-nerk.pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = with inputs; [
          ./user/faxy
          inputs.nix-doom-emacs-unstraightened.homeModule
        ];
      };
    };
}
