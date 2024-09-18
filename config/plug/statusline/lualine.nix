{config, ...}: let
  colors = import ../../colors/${config.theme}.nix {};
in {
  plugins.lualine = {
    enable = true;
    settings = {
      globalstatus = true;
      disabledFiletypes = {
        statusline = ["dashboard" "alpha"];
      };
      theme = {
        normal = {
          a = {
            bg = "#b4befe";
            fg = "#1c1d21";
          };
          b = {
            bg = "nil";
          };
          c = {
            bg = "nil";
          };
          z = {
            bg = "nil";
          };
          y = {
            bg = "nil";
          };
        };
      };
      sections = {
        lualine_a = [
          ''
            {
              "mode",
              fmt = string.lower,
              color = { fg = "${colors.base04}", bg = "${colors.base00}" }
            }
          ''
        ];
        lualine_b = [
          ''
            {
              "branch",
              icon = "",
              color = { fg = "${colors.base04}", bg = "${colors.base00}" }
            }
          ''
          "diff"
        ];
        lualine_c = [
          ''
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
              color = { fg = "${colors.base08}", bg = "${colors.base00}" }
            }
          ''
        ];
        lualine_x = [
          ''
            {
              "filetype",
              icon_only = true
            }
          ''
        ];
        lualine_y = [
          ''
            {
              "filename",
              symbols = { modified = "", readonly = "", unnamed = "" },
              color = { fg = "${colors.base04}", bg = "${colors.base00}" }
            }
          ''
        ];
        lualine_z = [
          ''
            {
              "location",
              color = { fg = "${colors.base0B}", bg = "${colors.base00}" }
            }
          ''
        ];
      };
    };
  };
}
