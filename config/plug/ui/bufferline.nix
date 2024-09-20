{config, ...}: let
  colors = import ../../colors/${config.theme}.nix {};
in {
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          separator_style = "thick"; # "slant", "padded_slant", "slope", "padded_slope", "thick", "thin"
          mode = "buffers";
          themable = true;
        };
        highlights = {
          fill = {
            fg = colors.base00;
            bg = colors.base00;
          };
          background = {
            fg = colors.base03;
            bg = colors.base00;
          };
          buffer_selected = {
            fg = colors.base05;
            bg = colors.base00;
            bold = true;
            italic = false;
          };
          buffer_visible = {
            fg = colors.base03;
            bg = colors.base00;
          };
          close_button = {
            fg = colors.base03;
            bg = colors.base00;
          };
          close_button_visible = {
            fg = colors.base03;
            bg = colors.base00;
          };
          close_button_selected = {
            fg = colors.base08;
            bg = colors.base00;
          };
          indicator_selected = {
            fg = colors.base00;
            bg = colors.base00;
          };
          modified = {
            fg = colors.base03;
            bg = colors.base00;
          };
          modified_visible = {
            fg = colors.base00;
            bg = colors.base00;
          };
          modified_selected = {
            fg = colors.base0B;
            bg = colors.base00;
          };
          tab_close = {
            fg = colors.base00;
            bg = colors.base00;
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options = {
        desc = "Delete buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      options = {
        desc = "Switch to Other Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<cmd>BufferLineCloseRight<cr>";
      options = {
        desc = "Delete buffers to the right";
      };
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>BufferLineCloseLeft<cr>";
      options = {
        desc = "Delete buffers to the left";
      };
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>BufferLineCloseOthers<cr>";
      options = {
        desc = "Delete other buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferLineTogglePin<cr>";
      options = {
        desc = "Toggle pin";
      };
    }
    {
      mode = "n";
      key = "<leader>bP";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options = {
        desc = "Delete non-pinned buffers";
      };
    }
  ];
}
