" Variables to keep files out of my home directory
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
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
set wildmode=longest,list,full " better autocompletion
setlocal splitbelow splitright  " Splits open at bottom and right
au BufEnter * set fo-=c fo-=r fo-=o " Got rid of cancer autocomments
filetype off                  " required for vundle
" Folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""Mappings"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Set Leader Keys 
let g:mapleader = "\<Space>" " Set Leader to Space
" let g:maplocalleader = ','
" Better split navigation
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" Escape to get out of terminal mode
tnoremap <Esc> <C-\><C-n>
" Better tabbing
vnoremap < <gv
vnoremap > >gv
" Open the basic python template
nnoremap ,ifmain :-1read $HOME/.config/nvim/snippets/template.py<CR>o
nnoremap ,def :-1read $HOME/.config/nvim/snippets/def.py<CR>3la
nnoremap ,pytry :-1read $HOME/.config/nvim/snippets/pytry.py<CR>A<CR>

" Replace all is mapped to S
nnoremap S :%s//g<Left><Left>
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
    Plugin 'baskerville/vim-sxhkdrc'
    Plugin 'nvie/vim-flake8'
    " Plugin 'neoclide/coc.nvim'
    Plugin 'ycm-core/YouCompleteMe'
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
" Disable all default binds so I can control them with Which-key
let g:NERDCreateDefaultMappings = 0

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
                        \'c': ['<plug>NERDCommenterToggle'  , 'Toggle'],
                        \'$': ['<plug>NERDCommenterToEOL'  , 'EOL'],
                        \'a': ['<plug>NERDCommenterAppend'  , 'Append To End Of Line'],
                        \'b': ['<plug>NERDCommenterToEOL'  , 'which_key_ignore'],
                        \'u': ['<plug>NERDCommenterUncomment'  , 'Uncomment'],
                        \}
        " let g:which_key_map.c.A = 'Append'
        " let g:which_key_map.c.c = 'Comment'
        " let g:which_key_map.c.l = 'Align left'
        " let g:which_key_map.c.y = 'Comment and yank line'
        " let g:which_key_map.c.u = 'Uncomment line'
        " let g:which_key_map.c.s = 'Comment sexy'
        " let g:which_key_map.c.m = 'Minimal'
        " let g:which_key_map.c.i = 'Invert'
        " let g:which_key_map.c.n = 'Nested'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
