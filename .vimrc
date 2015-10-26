"====[ Vundle ]====

    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

"====[ Vundle Plugins ]====

    "Plugin 'L9'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'othree/html5.vim'
    "Plugin 'nathanaelkane/vim-indent-guides'
    "Plugin 'sjl/gundo.vim'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-projectionist'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    "Plugin 'tpope/vim-ragtag'
    Plugin 'tpope/vim-rails'
    Plugin 'tpope/vim-unimpaired'
    "Plugin 'MarcWeber/vim-addon-mw-utils'
    "Plugin 'tomtom/tlib_vim'
    "Plugin 'garbas/vim-snipmate'
    "Plugin 'honza/vim-snippets'
    Plugin 'scrooloose/nerdtree'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'klen/python-mode'
    "Plugin 'tsaleh/vim-matchit'
    "Plugin 'kana/vim-textobj-user'
    "Plugin 'nelstrom/vim-textobj-rubyblock'
    "Plugin 'Shutnik/jshint2.vim'
    Plugin 'Valloric/YouCompleteMe'
    "Plugin 'jondkinney/dragvisuals.vim'
    "Plugin 'jondkinney/vmath.vim'
    "Plugin 'mattn/emmet-vim'
    "Plugin 'derekwyatt/vim-scala'
    Plugin 'briancollins/vim-jst'
    Plugin 'bitc/vim-hdevtools'
    Plugin 'scrooloose/syntastic'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'kien/ctrlp.vim'

    call vundle#end()

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
    noremap <leader>t :NERDTreeTabsToggle<CR>
    noremap <leader>T :NERDTreeTabsFind<CR>

"====[ Dispatch ]====

    noremap <leader>m :Make<CR>

"====[ Fugitive ]====

    " Autodelete hidden fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    noremap <leader>gc :Gcommit<CR>
    noremap <leader>gd :Gdiff<CR>
    noremap <leader>gs :Gstatus<CR>
    noremap <leader>gw :Gwrite<CR>

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

"====[ syntastic ]====

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

"====[ hdevtools ]====

    noremap <leader>ht :HdevtoolsType<CR>
    noremap <leader>hi :HdevtoolsInfo<CR>
    noremap <leader>hc :HdevtoolsClear<CR>
