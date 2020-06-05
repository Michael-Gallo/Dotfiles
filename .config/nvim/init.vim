"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""Mappings"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set Leader Keys 
let g:mapleader = "\<Space>" " Set Leader to Space
let g:maplocalleader = ','

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Replace all is mapped to S
nnoremap S :%s//g<Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""General Vim Variables""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number relativenumber
set clipboard=unnamedplus     " sets the default yank buffer to the clipboard
set nocompatible              " be iMproved, required
set termguicolors             " needed for color schemes to change background colors
set noshowmode                " Doesn't need to show I'm in insert mode if lightline already does so
set hidden
set pumheight=15			  " Set pop up menu height
set tabstop=4 expandtab       " Make tab use 4 spaces instead
set smartindent autoindent smarttab
set autochdir				  " Working directory will always be set properly
filetype off                  " required for vundle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""Color Customization""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Have an auto command make the background color for dracula a little darker
function! DraculaCustomize() abort
	highlight Normal guibg=#181717
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme dracula call DraculaCustomize()
augroup END

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
    Plugin 'tpope/vim-eunuch'
    Plugin 'junegunn/fzf.vim'
    Plugin 'junegunn/fzf'
    Plugin 'liuchengxu/vim-which-key'
    Plugin 'arcticicestudio/nord-vim'
    Plugin 'dracula/vim'
    Plugin 'unblevable/quick-scope'
    Plugin 'tbastos/vim-lua'
filetype plugin indent on    " required
call vundle#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""Plugin Settings"""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""Set Color Scheme""""""""""
colorscheme dracula

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


""""""""""vim-which-key Settings""""""""""""""
set timeoutlen=300
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKeyVisual  ','<CR>
" Create an empty map
let g:which_key_map={}
let g:which_key_map.c = { 'name' : '+comments' }
let g:which_key_map.c.A = 'append'

" Make it so the map is actually assigned to the leader key
call which_key#register(' ', "g:which_key_map")

""""""""""quick-scope settings""""""""""""""
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
let g:qs_max_chars=150
