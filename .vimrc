" Reload vimrc on write
autocmd! bufwritepost .vimrc source %

" Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" Vundle Plugins

Bundle 'L9'
Bundle 'tpope/vim-fugitive'
Bundle 'FuzzyFinder'
Bundle 'airblade/vim-gitgutter'
Bundle 'othree/html5.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-unimpaired'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline'
Bundle 'klen/python-mode'

" End Vundle


filetype plugin indent on
syntax on

set hidden " Allow hidden buffers

set number " Show line numbers

" Tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Styles, fonts and colorschemes
set background=dark

let g:solarized_termtrans=1
colorscheme solarized

set colorcolumn=80 " Highlight the 80th column

" GUI
if has('gui_running')
  set guioptions=-t " Hide the toolbar
  set guifont=Menlo\ Regular\ for\ Powerline:h14
endif

" Windows
if has('win32')
  set columns=120
  set lines=50
  set gfn=Consolas:h9:cANSI
endif


" Mappings

" Tab switching
nnoremap <C-j> gt
nnoremap <C-k> gT

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv


" Plugin settings

" FuzzyFinder
noremap <leader>f :FufFile<CR>
noremap <leader>F :FufFileWithCurrentBufferDir<CR>
noremap <leader>b :FufBuffer<CR>
noremap <leader>r :FufRenewCache<CR>

" NERDTree
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
noremap <leader>t :NERDTreeToggle<CR>

" Fugitive
" Autodelete hidden fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

noremap <leader>gc :Gcommit<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gw :Gwrite<CR>

" Powerline
source ~/.vim/bundle/powerline/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2
set encoding=utf-8
