set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'rails.vim'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'vcscommand.vim'
Bundle 'project.tar.gz'
Bundle 'AutoComplPop' 
Bundle 'The-NERD-Commenter'
Bundle 'surround.vim'
Bundle 'scrooloose/syntastic'

"Language autocompletion
Bundle 'JSON.vim'
Bundle 'cocoa.vim'
Bundle 'scala.vim'
Bundle 'Erlang-plugin-package'
Bundle 'VimClojure'
Bundle 'haskell.vim'
Bundle 'checksyntax-B'
Bundle 'vim-coffee-script'
Bundle 'dbext.vim'
Bundle 'SQLComplete.vim'

set showcmd
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smartcase
set number
set incsearch
set autowrite

" Make the mouse work
set mouse=a

" Turn on auto indenting for pasted code
set pastetoggle=<F2>

filetype plugin indent on

if has("gui_running")
  set guifont=Consolas
  colorscheme molokai
endif