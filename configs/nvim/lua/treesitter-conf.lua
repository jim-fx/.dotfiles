local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.http = {
    install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = {"src/parser.c"},
        branch = "main"
    }
}

parser_configs.glsl = {
    filetype = "vert",
    filetypes = {"vert", "frag"}
}

require "nvim-treesitter.configs".setup {
    indent = {
        enable = true
    },
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
        "yaml",
        "prisma"
    },
    highlight = {enable = true}
}
