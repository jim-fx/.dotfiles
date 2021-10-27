local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.http = {
    install_info = {
      url = "https://github.com/NTBBloodbath/tree-sitter-http",
      files = {"src/parser.c"},
      branch = "main"
    }
  }
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "bash",
      "yaml",
      "http",
      "svelte",
      "css",
      "svelte",
      "typescript",
      "javascript",
      "go",
      "lua",
      "yaml"
    },
    highlight = {enable = true}
  }


