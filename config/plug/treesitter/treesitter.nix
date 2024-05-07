{pkgs, ...}: let
  nu-grammar = pkgs.tree-sitter.buildGrammar {
    language = "nu";
    version = "0.0.0+rev=358c4f5";
    src = pkgs.fetchFromGitHub {
      owner = "nushell";
      repo = "tree-sitter-nu";
      rev = "2d0dd587dbfc3363d2af4e4141833e718647a67e";
      hash = "sha256-A0Lpsx0VFRYUWetgX3Bn5osCsLQrZzg90unGg9kTnVg=";
    };
  };
  mlir-grammar = pkgs.tree-sitter.buildGrammar {
    language = "mlir";
    version = "0.0.0+rev=ab7708c";
    src = pkgs.fetchFromGitHub {
      owner = "artagnon";
      repo = "tree-sitter-mlir";
      rev = "ab7708c4aed1ff0919d6f6fd3e463fe75ba645be";
      hash = "sha256-OFhnAvbQOI5t4suRxCSlJ6Gya9wG9Uqb5F649fKhKAQ=";
    };
  };
in {
  filetype = {
    extension = {
      liq = "liquidsoap";
      nu = "nu";
      mlir = "mlir";
    };
  };

  plugins.treesitter = {
    enable = true;
    indent = true;
    folding = true;
    languageRegister = {
      nu = "nu";
      liq = "liquidsoap";
      mlir = "mlir";
    };
    nixvimInjections = true;
    grammarPackages =
      [
        nu-grammar
        mlir-grammar
      ]
      ++ pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

  extraFiles = {
    "/queries/nu/highlights.scm" = builtins.readFile "${nu-grammar}/queries/nu/highlights.scm";
    "/queries/nu/injections.scm" = builtins.readFile "${nu-grammar}/queries/nu/injections.scm";
    "/queries/highlights.scm" = builtins.readFile "${mlir-grammar}/queries/highlights.scm";
    "/queries/locals.scm" = builtins.readFile "${mlir-grammar}/queries/locals.scm";
  };
  extraConfigLua = ''
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.liquidsoap = {
      filetype = "liquidsoap",
    }
    parser_config.nu = {
      filetype = "nu",
    }
    parser_config.mlir = {
      filetype = "mlir",
    }

  '';
}
