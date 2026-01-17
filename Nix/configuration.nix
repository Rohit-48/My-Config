{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # file sys support 
  boot.supportedFilesystems = [ "ntfs" ];
  
  # nix garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };



  networking.hostName = "nixos"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.giyu = {
    isNormalUser = true;
    description = "giyu";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  # Nix Flake
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };


  # Hyprland
  programs.hyprland = {
	enable = true;
  };

  # Waybar
  programs.waybar = {
  	enable = true;
  };
  
  # font
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];
  
  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 1000;

    #shellAliases = {
      # ...
    #};

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';

    #ohMyZsh = {
      #enable = true;
      #plugins = [ "git" "dirhistory" "history" ];
      #theme="powerlevel10k/powerlevel10k";
    #};
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # udisk
  services.udisks2.enable = true;

  
  # Enable CUPS to print documents.
  services.printing.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	# Dev utils
	neovim git gh vim wget curl tmux unzip ripgrep fd tree tig ffmpeg-full starship wf-recorder
	n8n ollama

	#sys monitoring 
	htop btop 
	
	# scripting
	fastfetch nitch

	# Terminal
	kitty ghostty

	 # shell
    	zsh
    	oh-my-zsh
    	zsh-powerlevel10k
    	meslo-lgs-nf

	# dev pkgs
	nodejs_24 bun typescript pnpm
	gcc gdb cmake pkg-config
	python3 python3Packages.pip python3Packages.virtualenv
	go rustc cargo
	openjdk
	android-tools
    	cloudflared

	# Devops
	docker docker-compose

	# Application
	brave discord spotify obsidian chromium 
	
	#code-editor
	vscode  zed-editor
	code-cursor

	# math
	texliveFull   # LaTeX (assignments, reports)
  	graphviz      # graphs, automata, flow
  	gnuplot


	#Hyprland
	waybar
	hyprpaper
	hyprland
	rofi
	dunst
	slurp
	grim
	wl-clipboard
	cliphist
	eww
	pavucontrol
	networkmanagerapplet
	
	#spicetify
	spicetify-cli

	 # others
    	cbonsai
    	cowsay

	# File-Manager
	kdePackages.dolphin
	ntfs3g
	kdePackages.qtsvg

	# wallpaper
    	swww
    	pywal
  ];
  
 # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    font-awesome
    material-design-icons
    jetbrains-mono
    fira-code
  ];
   
  # Docker
  virtualisation.docker.enable = true;

  # enable bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  
  # Tailscale
  services.tailscale = {
    enable = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
