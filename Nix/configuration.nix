{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

  # Nix
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Save disk space automatically
  };

  # NEW: auto-optimise-store alone doesn't delete old generations/store paths.
  # Without gc, your 1TB SSD will slowly fill with every generation you've
  # ever built. This actually runs weekly and keeps the last 30 days.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # ============================================
  # SECURE BOOT CONFIGURATION
  # ============================================
  boot.supportedFilesystems = [ "ntfs" ];

  # Disable systemd-boot (Lanzaboote replaces it)
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Lanzaboote for Secure Boot
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl"; # Standard sbctl location
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel (important for security patches)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel Level Security
  boot.kernelParams = [
    "quiet"
    "splash" # NOTE: this does nothing unless you also enable a splash
             # screen via services.plymouth.enable = true; otherwise it's
             # a no-op flag sitting in your kernel cmdline. Left it since
             # it's harmless, but worth knowing.
    # Security hardening - prevents kernel exploits
    "lockdown=confidentiality"
    "loglevel=3"
  ];

  # REMOVED: security.lockKernelModules = true;
  # This has a long-standing, still-open nixpkgs bug (#29019) where it can
  # hide your /boot device after the system finishes booting, which breaks
  # `nixos-rebuild` entirely (no such device, error 19). On a machine you
  # rebuild often, this is a real risk, not a theoretical one. If you want
  # this hardening later, test it on a spare partition/VM first, and know
  # you'll likely need to also populate boot.kernelModules manually for
  # your filesystem type.

  # Enable kernel security features
  security.protectKernelImage = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable and configure firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 3001 8080 5173 ]; # dev server ports
    logRefusedConnections = true;
  };

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

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.giyu = {
    isNormalUser = true;
    description = "giyu";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "wireshark" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # ============================================
  # GRAPHICS / GPU
  # ============================================
  # NEW: you were missing this entirely. This is required for GPU
  # acceleration (video decode, Vulkan, CUDA, gaming) regardless of vendor.
  # As of NixOS 24.11+ this replaced the old hardware.opengl.* namespace.
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # needed for Steam/Proton and most Windows games via Wine
  };

  # NEW: your Dell G15 5530 has a hybrid Intel iGPU + RTX 3050 setup, but
  # you had zero NVIDIA config, meaning you're currently on nouveau (open
  # source, no CUDA, mediocre gaming perf) whether you meant to be or not.
  # This block gets you the proprietary driver with PRIME offload, which is
  # the right default for a laptop: iGPU handles desktop/browsing, NVIDIA
  # only spins up when you explicitly run something on it.
  #
  # You MUST fill in your actual PCI bus IDs before enabling — run
  # `lspci | grep -E "VGA|3D"` and translate e.g. 00:02.0 -> PCI:0:2:0.
  # Uncomment when ready:
  #
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;       # helps laptop suspend/resume
  #   open = false;                        # RTX 3050 (Ampere) works with either;
  #                                         # closed driver is currently more
  #                                         # stable for laptops with PRIME.
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   prime = {
  #     offload.enable = true;
  #     offload.enableOffloadCmd = true;   # gives you `nvidia-offload <cmd>`
  #     intelBusId = "PCI:0:2:0";          # fill in from lspci
  #     nvidiaBusId = "PCI:1:0:0";         # fill in from lspci
  #   };
  # };

  # Sound stuff
  hardware.enableAllFirmware = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # NEW: cheap insurance against OOM kills with 16GB RAM + Docker + IDEs +
  # Chrome + Rust compiles all running at once.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Hyprland
  # NOTE: this pulls Hyprland straight from the upstream flake's main
  # branch, which means it's built from source and tracks bleeding-edge
  # (pre-release) Hyprland rather than the version packaged in nixpkgs.
  # That's a legitimate choice if you want the newest features/fixes, but
  # it costs you longer rebuild times and higher odds of breakage on
  # `nix flake update`. If you'd rather have something that "just works"
  # and matches what's tested against your nixpkgs version, you can drop
  # this input entirely and just use `pkgs.hyprland` from nixpkgs instead.
  # Leaving your current setup as-is since it looks intentional.
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Waybar
  # NOTE: this launches waybar automatically as a systemd user service on
  # graphical-session.target. If your hyprland.conf ALSO has
  # `exec-once = waybar`, you'll get two instances competing. Pick one
  # launch method — I'd lean on letting this module own it and removing
  # any exec-once line for waybar in your Hyprland config.
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

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 1000;

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };

  # Zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # udisk
  services.udisks2.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Wireshark - lets your user capture packets without running as root.
  # Replaces the need for the raw `wireshark` package alone.
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark; # full GUI, not just wireshark-cli/tshark
  };

  # Tmux configuration
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      catppuccin
    ];
    extraConfig = ''
      set -g mouse on
      set -g history-limit 10000
      set -g @catppuccin_flavour "mocha"
      set -g @plugin 'tmux-plugin/tpm'
      set -g @plugin 'tmux-plugin/tmux-sensible'
      set -g @plugin 'tmux-plugin/vim-tmux-navigator'
      set -g @catppuccin_status_modules_right ""
      set -g @catppuccin_status_modules_left "session"
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Dev utils
    neovim git gh vim wget jq curl tmux unzip ripgrep fd tree tig ffmpeg-full starship wf-recorder
    n8n ollama fzf eza bat zoxide

    # sys monitoring
    htop btop

    # secureboot
    sbctl

    # scripting
    fastfetch nitch

    # Terminal
    kitty ghostty

    # shell
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    meslo-lgs-nf
    lazygit

    # dev pkgs
    nodejs_24 bun typescript pnpm hugo
    gcc gdb cmake pkg-config
    python3 uv python3Packages.pip python3Packages.virtualenv
    go rustc cargo
    openjdk
    android-tools
    cloudflared
    kubernetes
    python313Packages.debugpy
    tailwindcss-language-server
    typescript-language-server
    vscode-css-languageserver

    # Devops
    # REMOVED standalone `docker` package: virtualisation.docker.enable
    # below already provides the docker CLI on PATH. Listing it here too
    # was redundant, not harmful, just noise.
    docker-compose

    # Application
    brave discord spotify obsidian chromium obs-studio

    # code-editor soon i will be a vim guy.
    vscode
    code-cursor
    jetbrains.rust-rover
    jetbrains.datagrip
    zed-editor

    # math
    texliveFull
    graphviz
    gnuplot

    # Hyprland
    waybar
    hyprpaper
    hyprshot
    hyprland
    rofi
    dunst
    slurp
    grim
    wl-clipboard
    cliphist
    pavucontrol
    brightnessctl
    networkmanagerapplet

    # spicetify
    spicetify-cli

    # others
    cbonsai
    cowsay

    # Media
    vlc gthumb

    # File-Manager
    kdePackages.dolphin
    ntfs3g exfat
    kdePackages.qtsvg

    # PDF reader
    kdePackages.okular

    # wallpaper
    # NOTE: `awww` isn't a typo — swww was renamed/forked to awww upstream,
    # this is the live current package name in nixpkgs. Kept as-is. You
    # also have hyprpaper above; both do the same job, so pick one to
    # actually use day-to-day (doesn't hurt to have both installed).
    awww
    pywal

    # Security tools
    nmap
    wireshark # kept here too so the package is available even if you
              # ever flip programs.wireshark.enable off
    tcpdump
    dig

    # ai cli tools i am doing it i am doing it oooooooooo.
    opencode

    # Sounds
    sof-firmware easyeffects

    inotify-tools
    playerctl
    quickshell

    # CyberStuff
    sherlock
    burpsuite
    python3Packages.pwntools
    # REMOVED duplicate `burpsuite` entry that was listed twice

    # image-manipulation
    gimp
    telegram-desktop
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

  # TRIM for SSD health (IMPORTANT for longevity)
  services.fstrim.enable = true;

  # AppArmor (alternative to SELinux, easier to use)
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Disable core dumps (can contain sensitive data)
  systemd.coredump.enable = false;
  # Disable crash reporter
  environment.etc."systemd/coredump.conf".text = ''
    [Coredump]
    Storage=none
  '';

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user.name = "Rohit";
      user.email = "rohitmandavkar3577@gmail.com";
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      glibc
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option.
  #
  # NOTE: 25.11 hit official end-of-life on 2026-06-30 (current stable is
  # 26.05 "Yarara"), but that's irrelevant to this value — stateVersion is
  # NOT a channel/version pin, it's a one-time marker for default DB/format
  # versions so upgrades don't silently break your data. You're already on
  # nixos-unstable in your flake, so you're getting current packages
  # regardless. Do not bump this just because a release went EOL.
  system.stateVersion = "25.11";
}

