{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hypr-lua.url = "github:SatelliteDish/hypr-lua";
    spilltea.url = "github:anotherhadi/spilltea";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs = {
      doomdir.url = "github:faximilie/quakemacs";
      };
    };
  };
  outputs = inputs@{
    nixpkgs,
    spilltea,
    home-manager,
    nix-doom-emacs-unstraightened,
    ...
  }: {
    nixosConfigurations.fred-nerk = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = with inputs; [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
          home-manager.users.faxy = ./home.nix;
        }
      ];
    };
    homeConfigurations."faxy" = home-manager.lib.homeManagerConfiguration {
      inherit nixpkgs;
      home-manager.extraSpecialArgs = { inherit inputs; };
      modules = with inputs; [
        ./home.nix
        nix-doom-emacs-unstraightened.homeModule
        stylix.nixOsModules.stylix
      ];
    };
  };
}
