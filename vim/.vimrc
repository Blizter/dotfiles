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

" Set up vim-arline and vim-airline-theme
let g:airline_theme='luna'
let g:airline#extensions#tabline#ePluginsnabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" Format the status line
" This status line comes from Pierre Bourdon's vimrc
"set statusline=%f\ %l\|%c\ %m%=%p%%\ (%Y%R)

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full

" Disable bell completely
set visualbell
set t_vb=

" Color the column after textwidth, usually the 80th
if version >= 703
  set colorcolumn=+1
endif

" Display whitespace characters
set list
set listchars=tab:>─,eol:¬,trail:\ ,nbsp:¤

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

