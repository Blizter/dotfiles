""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:
"   This is the .vimrc file
"
" Maintainer:
"   Blizter
"
" Complete_version:
"   This config file is based on the following :
"       You can find the complete configuration,
"       including all the plugins used, here:
"       https://github.com/Chewie/configs
"
" Acknowledgements:
"  this config file is based on this guy's work :
"  https://github.com/Chewie/configs
"
""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins loading
packloadall

" Load all help tags
silent! helptags ALL

" Welcome to the future
set nocompatible

" Enable filetype detection for plugins and indentation options
filetype plugin indent on

" Reload a file when it is changed from the outside
set autoread

" Write the file when we leave the buffer
set autowrite

" Disable backups, we have source control for that
set nobackup

" Use the clipboard as default register
set clipboard=unnamedplus

" Force encoding to utf-8, for systems where this is not the default (windows
" comes to mind)
set encoding=utf-8

" Disable swapfiles too
set noswapfile

" Hide buffers instead of closing them
set hidden

" Set the time (in milliseconds) spent idle until various actions occur
" In this configuration, it is particularly useful for the tagbar plugin
set updatetime=500

" For some stupid reason, vim requires the term to begin with "xterm", so the
" automatically detected "rxvt-unicode-256color" doesn't work.
set term=xterm-256color

" appending paths to tags for
set tags+=.git/tags

""""""""""""""""""""""""""""""""""""""""""""""""""
" User interface
""""""""""""""""""""""""""""""""""""""""""""""""""
" Make backspace behave as expected
set backspace=eol,indent,start

" Set the minimal amount of lignes under and above the cursor
" Useful for keeping context when moving with j/k
set scrolloff=5

" Show current mode
set showmode

" Show command being executed
set showcmd

" Show line number
set number relativenumber

" Always show status line
set laststatus=2

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full

" Disable bell completely
set visualbell
set t_vb=

" Display whitespace characters
set list
set listchars=tab:>─,eol:¬,trail:·,nbsp:¤,space:·,precedes:«,extends:»
set fillchars=vert:│

" Enables syntax highlighting in the editor and netrw
syntax on
syntax enable

" Enable Doxygen highlighting
let g:load_doxygen_syntax=1

" Briefly show matching braces, parens, etc
set showmatch

" Disable preview window on completion
set completeopt=longest,menuone

" color theme Palette for text editor
colorscheme photon

" Highlight characters after 80th column
highlight OverLength term=bold cterm=bold
match OverLength /\%81v.\+/

" Cursorline as highlight instead of underline 
set cursorline
hi CursorLine term=bold cterm=bold 

""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Settings
""""""""""""""""""""""""""""""""""""""""""""""""""
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Set up vim-arline and vim-airline-theme
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

""""""""""""""""""""""""""""""""""""""""""""""""""
" Search options
""""""""""""""""""""""""""""""""""""""""""""""""""
" allows search into subfolders
set path+=**

" Ignore case on search
set ignorecase

" Ignore case unless there is an uppercase letter in the pattern
set smartcase

" Move cursor to the matched string
set incsearch

""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation options
""""""""""""""""""""""""""""""""""""""""""""""""""
" The length of a tab
" This is for documentation purposes only,
" do not change the default value of 8, ever.
set tabstop=8

" The number of spaces inserted/removed when using < or >
set shiftwidth=4

" The number of spaces inserted when you press tab.
" -1 means the same value as shiftwidth
set softtabstop=-1

" Insert spaces instead of tabs
set expandtab

" When tabbing manually, use shiftwidth instead of tabstop and softtabstop
set smarttab

" Set basic indenting (i.e. copy the indentation of the previous line)
" When filetype detection didn't find a fancy indentation scheme
set autoindent

" This one is complicated. See :help cinoptions-values for details
set cinoptions=(0,u0,U0,t0,g0,N-s
""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw options
""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove banner from netrw
let g:netrw_banner = 0

" Tree style list file display
let g:netrw_liststyle = 3

" open file in the same window, type :h g:netrw_browse_split
let g:netrw_browse_split = 0

" Change fron left splitting to right splitting
let g:netrw_altv = 1

" let opened winows take 5% of screen width
let g:netrw_winsize = 90

""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE configuration
""""""""""""""""""""""""""""""""""""""""""""""""""

"" Setting up linting Options

" Disable linting on file opening
let g:ale_lint_on_enter = 0

" Lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1

" airline extensions
let g:airline#extensions#ale#enabled = 1

"" Visuals for erros and warnings

" gutter open to show errors
let g:ale_sign_column_always = 1

" errors signs
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Linters config
let g:ale_linters = {
  \ 'python': ['pydocstyle'],
  \ 'markdown' : ['markdownlint']
  \ }

" Fixers config
let g:ale_fixers = {
  \ 'python' : ['autopep8', 'isort'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace']
  \ }

