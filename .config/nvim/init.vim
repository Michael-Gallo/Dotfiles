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

""""""""""Ranger Settings''''''''""""""""""
let g:ranger_map_keys = 0
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
" Create an empty map
let g:which_key_map={}
" Fuzzy Finder bindings
let g:which_key_map.f = { 'name' : 'Fuzzy Finder' , 
                        \'~': [':FZF ~'  , 'In Home'],
                        \'/': [':FZF /'  , 'In Root'],
                        \'.': [':FZF .'  , 'In Current Directory'],
                        \'u': [':FZF ..'  , 'In Upper Directory'],
                        \}
let g:which_key_map.r = [ 'Ranger' , 'Ranger' ] 
" NerdCommenter bindings
let g:which_key_map.c = { 'name' : '+comments' , 
                        \' ': ['<plug>NERDCommenterToggle'  , 'Toggle'],
                        \'$': ['<plug>NERDCommenterToEOL'  , 'EOL'],
                        \'a': ['<plug>NERDCommenterToEOL'  , 'which_key_ignore'],
                        \'b': ['<plug>NERDCommenterToEOL'  , 'which_key_ignore']
                        \}
        let g:which_key_map.c.A = 'Append'
        let g:which_key_map.c.c = 'Comment'
        let g:which_key_map.c.l = 'Align left'
        let g:which_key_map.c.y = 'Comment and yank line'
        let g:which_key_map.c.u = 'Uncomment line'
        let g:which_key_map.c.s = 'Comment sexy'
        let g:which_key_map.c.m = 'Minimal'
        let g:which_key_map.c.i = 'Invert'
        let g:which_key_map.c.n = 'Nested'

let g:which_key_map.s = { 'name' : '+Surround' , 
                        \'d': ['<Plug>Dsurround'  , 'Delete Surroundings'],
                        \'c': ['<Plug>Csurround'  , 'Change Surroundings'],
                        \'y': ['<Plug>Ysurround'  , 'Add Surroundings'],
                        \'v': ['<Plug>VSurround'  , 'Add Visual Surroundings'],
                        \'s': ['<Plug>Yssurround'  , 'Change surroundings (whole line)'],
                        \}

let g:which_key_map.w = { 'name' : '+Window' , 
                        \'s': ['split'  , 'Split Horizontally'],
                        \'v': ['vsplit'  , 'Split Vertically'],
                        \'n': ['new'  , 'New Window Horizontal'],
                        \'c': ['close'  , 'Close Window'],
                        \'o': ['only'  , 'Only Window'],
                        \'h': ['<C-W>h', 'Move Cursor Left'],
                        \'j': ['<C-W>j', 'Move Cursor Down'],
                        \'k': ['<C-W>k', 'Move Cursor Up'],
                        \'l': ['<C-W>l', 'Move Cursor Right'],
                        \}
" Make it so the map is actually assigned to the leader key
call which_key#register(' ', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKeyVisual  ','<CR>

""""""""""quick-scope settings""""""""""""""
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
let g:qs_max_chars=150
