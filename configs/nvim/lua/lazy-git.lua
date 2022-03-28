local Terminal = require("toggleterm.terminal").Terminal
local u = require("utils")
local lazygit =
    Terminal:new(
    {
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
            winblend = 0,
            border = "shadow"
        },
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
            Terminal:close()
        end
    }
)

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

local pnpm =
    Terminal:new(
    {
        cmd = "pnpm dev",
        dir = "git_dir",
        size = 5,
        direction = "vertical",
        on_close = function(term)
            Terminal:close()
        end
    }
)

function _pnpm_toggle()
    pnpm:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>d", "<cmd>lua _pnpm_toggle()<CR>", {noremap = true, silent = true})

local nvimConfig =
    Terminal:new(
    {
        cmd = "cd $HOME/.dotfiles && nvim configs/init.lua && cd -",
        direction = "float",
        on_close = function(term)
            Terminal:close()
            u.ReloadConfig()
        end
    }
)

function _nvimConfig_toggle()
    nvimConfig:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader><C-i>", "<cmd>lua _nvimConfig_toggle()<CR>", {noremap = true, silent = true})

require("toggleterm").setup {
    shade_terminals = true
}
