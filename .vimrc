" Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" Vundle Plugins

Bundle 'L9'
Bundle 'tpope/vim-fugitive'
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
Bundle 'klen/python-mode'
Bundle 'Shougo/unite.vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

" End Vundle


filetype plugin indent on
syntax on

set hidden " Allow hidden buffers

set number " Show line numbers

set wildmenu " Show command completions

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

" Unite
noremap <leader>f :Unite -start-insert file<CR>
noremap <leader>F :UniteWithBufferDir -start-insert file<CR>
noremap <leader>b :Unite -start-insert buffer<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " FuzzyFinder style actions
  imap <silent><buffer><expr> <C-j> unite#do_action('split')
  imap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-l> unite#do_action('tabopen')
endfunction"}}}

" NERDTree
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
noremap <leader>t :NERDTreeToggle<CR>
noremap <leader>T :NERDTreeFind<CR>

" Fugitive
" Autodelete hidden fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

noremap <leader>gc :Gcommit<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gw :Gwrite<CR>

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set encoding=utf-8

" Filetype specific settings

autocmd FileType javascript,ruby set foldmethod=indent
