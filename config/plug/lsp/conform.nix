{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = ''
        function(bufnr)
          if vim.g.format_on_save_enabled == nil then
            vim.g.format_on_save_enabled = true
          end
          if vim.g.format_on_save_enabled then
            return {
              timeout_ms = 500,
              lsp_fallback = true,
            }
          end
        end
      '';
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
    -- Function to toggle format on save
    local function toggle_format_on_save()
      vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
      if vim.g.format_on_save_enabled then
        vim.notify("Format on save enabled")
        -- Re-enable lsp-format for all buffers
        require("lsp-format").enable({})
        -- Re-enable null-ls format on save if it was disabled
        local null_ls_client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
        if null_ls_client then
          null_ls_client.server_capabilities.documentFormattingProvider = true
        end
      else
        vim.notify("Format on save disabled")
        -- Disable lsp-format for all buffers
        require("lsp-format").disable({})
        -- Disable null-ls format on save
        local null_ls_client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
        if null_ls_client then
          null_ls_client.server_capabilities.documentFormattingProvider = false
        end
      end
    end

    -- Create a user command to toggle format on save
    vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})
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
