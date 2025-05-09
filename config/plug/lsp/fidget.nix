{
  plugins.fidget = {
    enable = true;

    settings = {
      logger = {
        level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
        floatPrecision = 0.01; # Limit the number of decimals displayed for floats
      };
      progress = {
        pollRate = 0; # How and when to poll for progress messages
        suppressOnInsert = true; # Suppress new messages while in insert mode
        ignoreDoneAlready = false; # Ignore new tasks that are already complete
        ignoreEmptyMessage = false; # Ignore new tasks that don't contain a message

        # Clear notification group when LSP server detaches
        clearOnDetach = {
          __raw = ''
            function(client_id)
              local client = vim.lsp.get_client_by_id(client_id)
              return client and client.name or nil
            end
          '';
        };

        # How to get a progress message's notification group key
        notificationGroup = {
          __raw = ''
            function(msg)
              return msg.lsp_client.name
            end
          '';
        };

        ignore = []; # List of LSP servers to ignore
        lsp = {
          progressRingbufSize = 0; # Configure the nvim's LSP progress ring buffer size
        };

        display = {
          renderLimit = 16; # How many LSP messages to show at once
          doneTtl = 3; # How long a message should persist after completion
          doneIcon = "✔"; # Icon shown when all LSP progress tasks are complete
          doneStyle = "Constant"; # Highlight group for completed LSP tasks
          progressTtl = {
            __raw = "math.huge";
          };
          progressIcon = {
            pattern = "dots";
            period = 1;
          };
          progressStyle = "WarningMsg";
          groupStyle = "Title";
          iconStyle = "Question";
          priority = 30;
          skipHistory = true;

          # `formatMessage` must also be raw Lua, even if it’s just a "require" string
          formatMessage = {
            __raw = ''
              require("fidget.progress.display").default_format_message
            '';
          };

          formatAnnote = {
            __raw = ''
              function(msg)
                return msg.title
              end
            '';
          };
          formatGroupName = {
            __raw = ''
              function(group)
                return tostring(group)
              end
            '';
          };

          overrides = {
            rust_analyzer = {
              name = "rust-analyzer";
            };
          };
        };
      };

      notification = {
        pollRate = 10; # How frequently to update and render notifications
        filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
        historySize = 128; # Number of removed messages to retain in history
        overrideVimNotify = true;

        # Must also be raw Lua or `false`. Here we do raw-lua.
        redirect = {
          __raw = ''
            function(msg, level, opts)
              if opts and opts.on_open then
                return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
              end
            end
          '';
        };

        configs = {
          # Also changed to raw Lua code
          default = {
            __raw = "require('fidget.notification').default_config";
          };
        };

        window = {
          normalHl = "Comment";
          winblend = 0;
          border = "none";
          zindex = 45;
          maxWidth = 0;
          maxHeight = 0;
          xPadding = 1;
          yPadding = 0;
          align = "bottom";
          relative = "editor";
        };

        view = {
          stackUpwards = true;
          iconSeparator = " ";
          groupSeparator = "---";
          groupSeparatorHl = "Comment";
        };
      };
    };
  };
}
