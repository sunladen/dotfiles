set nocompatible

" Get Plug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')
  Plug 'dense-analysis/ale'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()

set encoding=utf-8
scriptencoding utf-8

set hidden
set noswapfile
set incsearch
set hls
set path=.,**
set nospell
set signcolumn=no
set tabstop=4 shiftwidth=4 autoindent smartindent
set noexpandtab
set nottimeout
set ttimeoutlen=10
set ruler
set number
set noshowmode
set laststatus=1

let g:netrw_dirhistmax = 0


" Show file options above the command line
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=LINCENSE,node_modules/*,.git/*

set wildcharm=<C-z>

" Ctr-P open wildmenu for edit *
map <C-p> :e *<C-z>


syntax on

highlight LineNr ctermfg=Black
highlight ColorColumn ctermbg=Black


" Enable system clipboard integration
set clipboard+=unnamedplus


nnoremap <SPACE> <Nop>
let mapleader=" "


" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>


" move among buffers with Ctrl
map <leader>h :bprev<CR>
map <leader>l :bnext<CR>

map [[ :silent! eval search('{', 'b')<CR>
map ]] :silent! eval search('{')<CR>


if &term =~ '^xterm'
  " use blinking vertical bar in insert mode
  let &t_SI = "\<Esc>[5 q"
  " use solid block otherwise
  let &t_EI = "\<Esc>[2 q"
  " clear screen on vim exit
  let &t_TE = "\<Esc>[H\<Esc>[2J"
endif


hi Normal guibg=NONE ctermbg=NONE


let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1

nmap <leader>j :ALENext<cr>
nmap <leader>n :lnext<cr>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


" Find files using Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
