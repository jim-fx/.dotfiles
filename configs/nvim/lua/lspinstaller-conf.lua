local lsp_installer = require("nvim-lsp-installer")
local lsp_format = require("lsp-format");
lsp_format.setup {}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end


lsp_installer.on_server_ready(
    function(server)

        local opts = {
          on_attach = lsp_format.on_attach
        }

        if server.name == "tsserver" then
          opts.commands  = {
            OrganizeImports = {
              organize_imports,
              description = "Organize Imports"
            }
          }
        end

        -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
        server:setup(opts)
    end
)
