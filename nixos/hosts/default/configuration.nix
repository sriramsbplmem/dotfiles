# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ariel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  #use hyprland
  programs.hyprland.enable = true;
  # Configure keymap in X11
  services.xserver = {
    enable =true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable =true;

    layout = "us";
    xkbVariant = "";
  };
  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

    #services.greetd = {
    #    enable =true;
    #    settings = rec {
    #     initial_session = {
    #        command ="Hyprland";
    #        user="zeatoen";
    #     };

    #     default_session = initial_session; 
    #    };

    #};
  # rtkit is optional but recommended
    security.rtkit.enable = true;
    #services.pipewire = {
    #enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
  # #If you want to use JACK applications, uncomment this
  #j#ack.enable = true;
    #};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zeatoen = {
    isNormalUser = true;
    description = "zeatoen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    kitty
    neofetch 
    rofi-wayland
    firefox
    pavucontrol 
    gammastep
    neovim
    swaylock
    waybar
    hyprpaper 
    vlc
    fzf
    dunst
    pamixer 
    brightnessctl
    playerctl 
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    git
    transmission-gtk
    inetutils
    # ffmpeg-full
    jellyfin-ffmpeg
    swayidle
    mysql-workbench
    
]; 
	fonts.packages = with pkgs;[
		nerdfonts
	];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:
  services = {
  	mysql.enable = true;
	mysql.package = pkgs.mariadb;
  };
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  

  #zeatoen
  xdg.portal = {

	enable = true;
	#extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
		

  #experimental features
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
	security.pam.services.swaylock={};
   
	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"zeatoen" = import ./home.nix; 
		};
	};
}
