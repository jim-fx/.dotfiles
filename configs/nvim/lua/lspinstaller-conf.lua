local lsp_installer = require("nvim-lsp-installer")
    require("lsp-format").setup {}


lsp_installer.on_server_ready(
    function(server)
        local opts = {
          on_attach = require "lsp-format".on_attach
        }
        

        -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
        server:setup(opts)
    end
)
