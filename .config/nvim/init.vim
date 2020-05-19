set number relativenumber
set clipboard=unnamedplus     " sets the default yank buffer to the clipboard
set nocompatible              " be iMproved, required
set noshowmode                " Doesn't need to show I'm in insert mode if lightline already does so
filetype off                  " required for vundle

" set the leader key to space
let g:mapleader = " "

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	"let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'tpope/vim-surround' " vim-surround needs to plugged before nerdcommenter to prevent key bind errors
	Plugin 'preservim/nerdcommenter'
	Plugin 'frazrepo/vim-rainbow'
	Plugin 'itchyny/lightline.vim'
	Plugin 'ap/vim-css-color'
	Plugin 'francoiscabrol/ranger.vim'
	Plugin 'vim-python/python-syntax'
	Plugin 'junegunn/goyo.vim'
	Plugin 'dhruvasagar/vim-table-mode'
	Plugin 'tpope/vim-eunuch'
call vundle#end()
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""Plugin Settings"""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""Nerd Commentor Settings""""""""""
let g:NERDSpaceDelims = 1  " makes it so nerdcommentor automatically adds a space after comments
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCompactSexyComs = 1

""""""""""Rainbow Parens Settings""""""""""

let g:rainbow_active = 1 " Activates rainbow parenthesis

""""""""""Light Line Settings""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'darcula'
      \ }

""""""""""Goyo Configuration""""""""""""""
let g:goyo_width = "80%"

""""""""""Vim Indent Settings""""""""""""""
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
