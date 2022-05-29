" Variables to keep files out of my home directory
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""General Vim Variables""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autochdir				  " Working directory will always be set properly
set clipboard=unnamedplus     " sets the default yank buffer to the clipboard
set colorcolumn=80            
set exrc                      " If there is a project level vimrc, use it
set hidden
set nocompatible              " be iMproved, required
set nohlsearch                " Highlighting turns off after search is completed
set noshowmode                " Doesn't need to show I'm in insert mode if lightline already does so
set noswapfile
set nobackup
set nowrap                    " Turns off wrapping
set number relativenumber
set pumheight=15			  " Set pop up menu height
set scrolloff=10              " Make cursor stay near the center
set smartindent autoindent smarttab
set tabstop=4 expandtab       " Make tab use 4 spaces instead
set termguicolors             " needed for color schemes to change background colors
set wildmode=longest,list,full " better autocompletion
setlocal splitbelow splitright  " Splits open at bottom and right
au BufEnter * set fo-=c fo-=r fo-=o " Got rid of cancer autocomments
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

call plug#begin()
     Plug 'tpope/vim-surround' " vim-surround needs to plugged before nerdcommenter to prevent key bind errors
	 Plug 'preservim/nerdcommenter'
     Plug 'frazrepo/vim-rainbow'
     Plug 'itchyny/lightline.vim'
     Plug 'ap/vim-css-color'
     Plug 'francoiscabrol/ranger.vim'
     Plug 'vim-python/python-syntax'
     Plug 'junegunn/goyo.vim'
     Plug 'tpope/vim-eunuch'
     Plug 'junegunn/fzf.vim'
     Plug 'junegunn/fzf'
     Plug 'liuchengxu/vim-which-key'
     Plug 'arcticicestudio/nord-vim'
     Plug 'dracula/vim'
     Plug 'unblevable/quick-scope'
     Plug 'tbastos/vim-lua'
     Plug 'baskerville/vim-sxhkdrc'
     Plug 'nvie/vim-flake8'
     Plug 'vifm/vifm.vim'
     " Plug 'neoclide/coc.nvim'
     Plug 'nvim-lua/plenary.nvim'
     Plug 'nvim-telescope/telescope.nvim'
     Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
    " Plugin 'Valloric/YouCompleteMe'
    " Plugin 'rdnetto/YCM-Generator'
" filetype plugin indent on    " required
call plug#end()
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

let g:which_key_map.t = { 'name' : '+Telescope',
                        \'s': [':Telescope live_grep', 'Search for String'],
                        \'f': [':Telescope find_files', 'Search for File'],
                        \'r': [':Telescope registers', 'Search through registers'],
                        \'b': [':Telescope buffers', 'Search through buffers'],
                        \'g': [':Telescope git_files', 'Search through git files'],
                        \'h': [':Telescope oldfiles', 'Search through file history'],
                        \ }
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
let g:ycm_global_ycm_extra_conf = '$HOME/.config/nvim/ycm_c_conf.py'
