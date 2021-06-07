set number

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
let g:material_theme_style = 'ocean-community'
colorscheme material

let mapleader = ","

nmap <F6> :NERDTreeToggle<CR>

let g:python3_host_prog = expand('~/.pyenv/shims/python3.9')
