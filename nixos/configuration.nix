# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, system,... }:

{
  # Nix Settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  services = {
    xserver.videoDrivers = ["nvidia"]; # Load nvidia driver for Xorg and Wayland
    upower.enable = true;
    xserver.enable = true; # Enable the X11 windowing system.
    xserver.xkb = { # Configure keymap in X11
      layout = "us";
      variant = "intl";
    };
    printing.enable = true; # Enable CUPS to print documents.
    pulseaudio.enable = false; # Enable sound with pipewire.
    mullvad-vpn.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true; If you want to use JACK applications, uncomment this
      #media-session.enable = true; Default for now
    };
    # openssh.enable = true; Enable the OpenSSH daemon.
    # xserver.libinput.enable = true; Enable touchpad support (enabled default in most desktopManager).
    displayManager.dms-greeter = {
     enable = true;
     compositor.name = "hyprland";
    };
  };

  # Hardware Settings
  hardware = {
    enableAllFirmware = true;
    graphics.enable = true; # Enable OpenGL
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      # sudo lshw -c display to find PCI Bus IDs (convert to decimal)
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };


  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.serj = {
    isNormalUser = true;
    description = "Sergio Jimenez";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Programs Options
  programs = {
    firefox.enable = true;
    steam.enable = true;
    git = {
      enable = true;
      config = {
        user = {
	  name = "Sergio Jimenez";
	  email = "sergio.jimenezcedron@icloud.com";
	};
	init.defaultBranch = "main";
	safe.directory = "/etc/nixos";
      };
    };
    foot = {
      enable = true;
      theme = "gruvbox-dark";
      settings = {
        main.font = "JetBrainsMono Nerd Font:size=11";
      };
    };
    bash.shellAliases = {
      ll = "ls -lh";
      la = "ll -A";
      lg = "lazygit";
    };
    starship.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    dms-shell = {
      enable = true;
      systemd = {
        enable = true;
	restartIfChanged = true;
      };
    };
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    lshw
    signal-desktop
    obsidian
    spotify
    fastfetch
    lazygit
    bibata-cursors
    zed-editor
    qbittorrent
    mullvad-vpn
    vlc
    jellyfin
    jellyfin-desktop
    anki
    fuzzel
    libnotify
    kdePackages.dolphin
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
  
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      16720 # qbittorrent
      8096 # jellyfin
    ];
    allowedUDPPorts = [
      16720
      8096
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
