# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  #imports =
  #  [ # Include the results of the hardware scan.
  #    ./hardware-configuration.nix
  #    # home-manager.nixosModules.default
  #  ];

  # Bootloader.
  boot = {
    initrd.systemd.network.wait-online.enable = false;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  systemd = {
    services.tailscaled.serviceConfig.Environment = [ 
      "TS_DEBUG_FIREWALL_MODE=nftables" 
    ];
    network.wait-online.enable = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      mesa
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.mesa
    ];
  };

  
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.hostName = "fred-nerk"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

   fonts = {
     packages = with pkgs; [
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      source-code-pro
      ttf_bitstream_vera
    ];

    # These settings enable default fonts for your system.  This setting is very
    # important.  It lets fontconfig know that you want to fall back to a Japanese
    # font (for example "IPAGothic") if an application tries to show fonts with
    # Japanese.  For instance, this is important if you are using a terminal
    # emulator and you `cat` some Japanese text to the screen. If you don't have
    # "defaultFonts" configured, fontconfig will pick a random Japanese font to
    # use.  If you have this "defaultFonts" setting configured, fontconfig will
    # pick the font you have selected.  This makes sure Japanese fonts look nice.
    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };

   };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
    };

    locate = {
      enable = true;
      package = pkgs.plocate;
      interval = "hourly";
      pruneNames = [
        "*.pyc"
        "*.pyo"
        ".DS_Store"
        ".Trash-"
        ".bzr"
        ".cache"
        ".cargo"
        ".class"
        ".git"
        ".hg"
        ".local"
        ".svn"
        ".thumbnail"
        "argo"
        "node_modules"
        "ower_components"
      ];
    };
    tailscale.enable = true;
    xserver = {
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "au";
        variant = "";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."faxy" = {
    isNormalUser = true;
    description = "Faxy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  # home-manager.users."faxy" = { pkgs, ... }: {
  #   home.packages = with pkgs; [
  #     # (pkgs.callPackage ./pkgs/yacy/default.nix {} )
  #   ];
  #   #programs.bash.enable = true;
  #   #programs.emacs.enable = true;

  #   # The state version is required and should stay at the version you
  #   # originally installed.
  #   home.stateVersion = "26.05";
  # };

  security =  {
  	polkit.enable = true;
    rtkit.enable = true;
    isolate.enable = true;
    soteria.enable = true;
  };

  programs = {

      enable = true;
    };
    nix-index.enable = true;

    # neovide.enable = true;
      
    neovim.defaultEditor = true;
    

    #command-not-found.enable = true;
    solaar = {
      enable = true;
      userService.enable = true;
    };

    uwsm.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment= {
    # loginShellInit = ''
    #   if uwsm check may-start; then
    #     exec uwsm start default
    #   fi
    # '';
    localBinInPath = true;
    variables = let
      editor = "${lib.getExe pkgs.neovim}";
    in rec {


      XDG_LOCAL_HOME="$HOME/.local";
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_SRC_HOME   = "$HOME/.local/src";
      XDG_STATE_HOME  = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME    = "$HOME/.local/bin";
      PATH = [ 
        "${XDG_BIN_HOME}"
      ];

      EDITOR = editor;
      VISUAL = editor;
      SUDO_EDITOR = editor;
    }; #// lib.genAttrs ["EDITOR" "VISUAL" "SUDO_EDITOR"] (_: editor);

    systemPackages = with pkgs; [
      # I don't want to ever be without
      coreutils
      
      # Required build tools
      curl wget
      git
      gcc gnumake libtool

      # Basic archive support
      zip unzip gnutar

      # GPG for verifying files
      gnupg

      # I need an editor
      neovim

      # Networking stuff
      networkmanager
      tailscale

    ];
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking = {
    nftables.enable = true;
    firewall = {
       enable = true;
       trustedInterfaces = [ config.services.tailscale.interfaceName ];
       allowedUDPPorts = [ config.services.tailscale.port ];
     };

  };

  nix = {
    enable = true;
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://doom-emacs-unstraightened.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "doom-emacs-unstraightened.cachix.org-1:O5oOlRPnmQEvVaFyuMTmthCEooHbrg54WgSLR07tmg4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
