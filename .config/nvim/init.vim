set number relativenumber
set clipboard=unnamedplus     " sets the default yank buffer to the clipboard
set nocompatible              " be iMproved, required
set noshowmode                " Doesn't need to show I'm in insert mode if lightline already does so
filetype off                  " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'frazrepo/vim-rainbow'
Plugin 'itchyny/lightline.vim'
Plugin 'ap/vim-css-color'
Plugin 'francoiscabrol/ranger.vim'
call vundle#end()
filetype plugin indent on    " required

let g:rainbow_active = 1 " Activates rainbow parenthesis
let g:lightline = {
      \ 'colorscheme': 'darcula'
      \ }
