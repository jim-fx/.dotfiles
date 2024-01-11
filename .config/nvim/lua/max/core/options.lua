local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = " "

g.loaded_netrwPlugin = 1
g.loaded_netrw = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrw_gitignore = 1

opt.autowrite = true           -- Enable auto write
opt.clipboard = "unnamedplus"  -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3           -- Hide * markup for bold and italic
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3         -- laststatus=3 enables global statusline
opt.list = false           -- Show some invisible characters (tabs...
opt.mouse = "a"            -- Enable mouse mode
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
vim.cmd [[ set nonu ]]     -- Right align active number
opt.number = true          -- Print line number
opt.relativenumber = true  -- Relative line numbers

-- vim.api.nvim_set_option('number', true)
-- vim.api.nvim_set_option('relativenumber', true)

-- Set the current line number to be the actual one
vim.cmd [[autocmd InsertEnter * set relativenumber]]
vim.cmd [[autocmd InsertLeave * set norelativenumber]]

opt.scrolloff = 4        -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true    -- Round indent
opt.shiftwidth = 2       -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false     -- Dont show mode since we have a statusline
opt.sidescrolloff = 8    -- Columns of context
opt.signcolumn = "no"    -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true     -- Don't ignore case with capitals
opt.smartindent = true   -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap

opt.foldenable = false;
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
