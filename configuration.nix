{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  #Automatic updateing
  system.autoUpgrade.enable = false;
  system.autoUpgrade.dates = "weekly";

  #Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Cairo";

  i18n.defaultLocale = "en_US.UTF-8";

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      middleEmulation = true;
    };
  };


  programs.niri.enable = true;
  services.displayManager.ly.enable = true;
  

  services.xserver.xkb = {
    layout = "us,ara";
    options = "grp:alt_shift_toggle";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ahmed = {
      isNormalUser = true;
      description = "AHMED";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
     ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ahmed" = { 
        home.username = "ahmed";
        home.homeDirectory = "/home/ahmed";
        home.stateVersion = "25.11";
        home.packages = with pkgs; [
          fuzzel
          waybar
          swaybg
          alacritty
          mako
          xwayland
        ];
        wayland.windowManager.niri.settings = {
        };

          programs.zsh = {
             enable = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            shellAliases = {
            nixo-up = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos";
          };
        };
      };
    };
  };

  programs.firefox.enable = false;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    aria2
    wl-clipboard
    fastfetch
    htop
    git
    vlc
    distrobox
    google-chrome
    haskell.compiler.native-bignum.ghc9103
    haskellPackages.haskell-language-server
    haskellPackages.cabal-install
    stack
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     nerd-fonts.symbols-only
  ];

#  fonts.packages = with pkgs; [
#     (pkgs.stdenv.mkDerivation {
#       name = "ahmed-nerd-fonts";
#       src = ./fonts;
#       installPhase = ''
#         mkdir -p $out/share/fonts/truetype
#         mkdir -p $out/share/fonts/opentype
#         find . -name "*.ttf" -exec cp -v {} $out/share/fonts/truetype/ \;
#         find . -name "*.otf" -exec cp -v {} $out/share/fonts/opentype/ \;
#       '';
#     })
#   ];

  services.power-profiles-daemon.enable = false;
 
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "balance_power";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balance_power";

      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "balance_power";

      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  system.stateVersion = "25.11";
  
  
  }
