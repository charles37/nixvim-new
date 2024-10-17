{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notifyOnError = true;
      formattersByFt = {
        liquidsoap = ["liquidsoap-prettier"];
        html = [["prettierd" "prettier"]];
        css = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        python = ["black"];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [["prettierd" "prettier"]];
        yaml = ["yamllint" "yamlfmt"];
      };
    };
  };

  extraConfigLua = ''
    -- Initialize a variable to track the state
    vim.g.format_on_save_enabled = true

    -- Function to toggle format on save
    local function toggle_format_on_save()
      vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
      if vim.g.format_on_save_enabled then
        vim.notify("Format on save enabled")
      else
        vim.notify("Format on save disabled")
      end
    end

    -- Create a user command to toggle format on save
    vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})

    -- Override Conform's format_on_save function
    local conform = require("conform")
    local original_format_on_save = conform.format_on_save

    conform.format_on_save = function(bufnr)
      if vim.g.format_on_save_enabled then
        original_format_on_save(bufnr)
      end
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleFormatOnSave<CR>";
      options = {
        silent = true;
        desc = "Toggle format on save";
      };
    }
  ];
}
