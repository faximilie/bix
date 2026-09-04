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
  outputs = inputs@{ nixpkgs, home-manager, nix-doom-emacs-unstraightened, ... }:
    {
      nixosConfigurations.jake-long = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; moduleClass = "nixos";};
        modules = with inputs; [
          (import-tree ./hosts)
          (import-tree ./mods)
          (import-tree ./users)
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs; moduleClass = "home";};
              users.faxy = { pkgs, ... }: {
                imports = [
                  ./mods/desktop/sway.nix
                  (import-tree ./mods/editor)
                  (import-tree ./users)
                  inputs.nix-doom-emacs-unstraightened.homeModule
                ];
              };
            };
          }
        ];
      };
      homeConfigurations."faxy" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs; moduleClass = "home";};
        modules = with inputs; [
          ./mods/desktop/sway.nix
          (import-tree ./mods/editor)
          (import-tree ./users)
          inputs.nix-doom-emacs-unstraightened.homeModule
        ];
      };
    };
}
