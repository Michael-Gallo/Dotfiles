set number relativenumber
set clipboard=unnamedplus
set nocompatible              " be iMproved, required
set noshowmode
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on    " required

let g:lightline = {
      \ 'colorscheme': 'darcula'
      \ }
