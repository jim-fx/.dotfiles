set number

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'

" A status line to the bottom
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale'

" Autocompletion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Display Images in Vim
Plug 'ashisha/image.vim'

" Svelte support
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Multi Cursor select
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'kristijanhusak/vim-dadbod-ui'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

let g:svelte_preprocessors = ['typescript']

" Theme
syntax enable
let g:material_theme_style = 'ocean-community'
colorscheme material

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'background': 'dark',
      \ }

let mapleader = ","
nmap <leader>rn <Plug>(coc-rename)

" 
nmap <C-p> :FZF<CR>

" COC Configs
set updatetime=300

" NerdTREE config
nmap <F6> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
au VimEnter *  NERDTree
au VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd p | endif
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nnoremap H gT
nnoremap L gt

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
