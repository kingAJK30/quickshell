{ self }:
{ config, lib, pkgs, ... }:
{
  options.programs.quickshell = {
    ollamaChatModel = lib.mkOption {
      type = lib.types.str;
      default = "qwen3:8b";
      description = "Ollama model used by the dynamic island's ask-ollama mode.";
    };

    theme = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = ''
        Theme values written to theme.json (wallpaper, colors, fonts) —
        shape matches services/Theme.qml's expectations.
      '';
    };
  };

  config = {
    home.packages = [
      pkgs.quickshell
      pkgs.curl
      pkgs.cava
    ];

    wayland.windowManager.sway.config.startup = lib.mkIf config.wayland.windowManager.sway.enable [
      { command = "${pkgs.quickshell}/bin/quickshell"; }
    ];

    xdg.configFile = {
      "quickshell/components".source = "${self}/components";
      "quickshell/modules".source = "${self}/modules";
      "quickshell/services".source = "${self}/services";
      "quickshell/shell.qml".source = "${self}/shell.qml";

      "quickshell/theme.json".text = builtins.toJSON config.programs.quickshell.theme;
      "quickshell/ask.json".text = builtins.toJSON { model = config.programs.quickshell.ollamaChatModel; };
    };
  };
}
