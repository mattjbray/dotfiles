"====[ Vundle ]====

    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()

    Bundle 'gmarik/vundle'

"====[ Vundle Plugins ]====

    "Bundle 'L9'
    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'
    "Bundle 'othree/html5.vim'
    "Bundle 'nathanaelkane/vim-indent-guides'
    "Bundle 'sjl/gundo.vim'
    Bundle 'tpope/vim-dispatch'
    Bundle 'tpope/vim-projectionist'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-surround'
    "Bundle 'tpope/vim-ragtag'
    Bundle 'tpope/vim-rails'
    Bundle 'tpope/vim-unimpaired'
    "Bundle 'MarcWeber/vim-addon-mw-utils'
    "Bundle 'tomtom/tlib_vim'
    "Bundle 'garbas/vim-snipmate'
    "Bundle 'honza/vim-snippets'
    Bundle 'scrooloose/nerdtree'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'klen/python-mode'
    "Bundle 'tsaleh/vim-matchit'
    "Bundle 'kana/vim-textobj-user'
    "Bundle 'nelstrom/vim-textobj-rubyblock'
    "Bundle 'Shutnik/jshint2.vim'
    Bundle 'Valloric/YouCompleteMe'
    "Bundle 'jondkinney/dragvisuals.vim'
    "Bundle 'jondkinney/vmath.vim'
    "Bundle 'mattn/emmet-vim'
    "Bundle 'derekwyatt/vim-scala'
    Bundle 'briancollins/vim-jst'

"====[ General ]====

    filetype plugin indent on
    syntax on

    set hidden " Allow hidden buffers

    set wildmenu " Show command completions

    set ignorecase
    set smartcase

    set grepprg=ack

"====[ Tab settings ]====

    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab

"====[ Styles, fonts and colorschemes ]====

    set background=dark
    let g:solarized_termtrans=1
    colorscheme solarized

    set number " Show line numbers

    " Highlight the 80th column
    call matchadd('ColorColumn', '\%81v', 100)

"====[ Set foldmethod=indent for javascript, jst and ruby files ]======

    autocmd FileType javascript,jst,ruby set foldmethod=indent

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

"====[ GUI ]====

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

"========================
"====[ Key Mappings ]====
"========================

"====[ Tab switching ]====

    nnoremap <C-j> gt
    nnoremap <C-k> gT

"====[ Keep selection after indent ]====

    vnoremap < <gv
    vnoremap > >gv

"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]====

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

"===========================
"====[ Plugin settings ]====
"===========================

"====[ Python-mode ]====

    " Don't interfere with YouCompleteMe
    let g:pymode_rope_complete_on_dot = 0

    " Don't regenerate .ropeproject on save
    let g:pymode_rope_regenerate_on_write = 0

"====[ NERDTree ]====

    let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
    noremap <leader>t :NERDTreeToggle<CR>
    noremap <leader>T :NERDTreeFind<CR>

"====[ Dispatch ]====

    noremap <leader>m :Make<CR>

"====[ Fugitive ]====

    " Autodelete hidden fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    noremap <leader>gc :Gcommit<CR>
    noremap <leader>gd :Gdiff<CR>
    noremap <leader>gs :Gstatus<CR>
    noremap <leader>gw :Gwrite<CR>

"====[ Powerline ]======

    python from powerline.vim import setup as powerline_setup
    python powerline_setup()
    python del powerline_setup
    set laststatus=2
    set encoding=utf-8

"====[ Dragvisuals ]======

    vmap  <expr>  <LEFT>   DVB_Drag('left')
    vmap  <expr>  <RIGHT>  DVB_Drag('right')
    vmap  <expr>  <DOWN>   DVB_Drag('down')
    vmap  <expr>  <UP>     DVB_Drag('up')
    vmap  <expr>  D        DVB_Duplicate()

    " Remove any introduced trailing whitespace after moving...
    let g:DVB_TrimWS = 1

"====[ vmath ]====

    vmap <expr>  ++  VMATH_YankAndAnalyse()
    nmap         ++  vip++
