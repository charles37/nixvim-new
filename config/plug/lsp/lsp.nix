{
  plugins = {
    lsp-format = {enable = true;};
    lsp = {
      enable = true;
      #inlayHints = true;
      servers = {
        #ccls = {
        #  enable = true;
        #  initOptions.clang.extraArgs = [
        #    "--gcc-toolchain=/usr"
        #    "--offset-encoding=utf-16"
        #  ];
        #};
        clangd = {
          enable = true;
          cmd = ["clangd" "--offset-encoding=utf-16"];
        };
        eslint = {enable = true;};
        html = {enable = true;};
        lua-ls = {enable = true;};
        nil-ls = {enable = true;};
        marksman = {enable = true;};
        pyright = {enable = true;};
        gopls = {enable = true;};
        terraformls = {enable = true;};
        ts-ls = {enable = true;};
        yamlls = {enable = true;};
        hls = {enable = true;};
        rust-analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
          settings = {
            #inlayHints = {
            #  bindingModeHints.enable = true;
            #  chainingHints.enable = true;
            #  closingBraceHints = {
            #    enable = true;
            #    minLines = 0;
            #  };
            #  closureCaptureHints.enable = true;
            #  closureReturnTypeHints.enable = "always";
            #  discriminantHints.enable = "always";
            #  expressionAdjustmentHints = {
            #    enable = "always";
            #    hideOutsideUnsafe = false;
            #    mode = "postfix";
            #  };
            #  lifetimeElisionHints = {
            #    enable = "always";
            #    useParameterNames = true;
            #  };
            #  maxLength = null; # No limit
            #  parameterHints.enable = true;
            #  rangeExclusiveHints.enable = true;
            #  renderColons = true;
            #  typeHints = {
            #    enable = true;
            #    hideClosureInitialization = false;
            #    hideNamedConstructor = false;
            #  };
            #  implicitDrops.enable = true;
            #};
            genericParameterHints = {
              const.enable = true;
              lifetime.enable = true;
              type.enable = true;
            };
          };
        };
      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
