call plug#begin()
" Main
Plug 'airblade/vim-rooter'
Plug 'mattn/emmet-vim', { 'for': ['html','xhtml','css','sass','scss','xml'] }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'

" Other
Plug 'jiangmiao/auto-pairs'  " alt-p / ctrl-v to disable in insert mode
Plug 't9md/vim-choosewin'    " - to choose window
Plug 'wellle/targets.vim'
Plug 'tommcdo/vim-lion'      " gl / gL
Plug 'kkoenig/wimproved.vim' " F9 to center window
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" For future research
" Plug 'tpope/vim-fugitive'
" Plug 'kien/ctrlp.vim'
" Plug 'Valloric/MatchTagAlways', { 'for': ['html'] }

" Themes
Plug 'MaxSt/FlatColor'
" Plug 'joshdick/onedark.vim'
" Plug 'cocopon/iceberg.vim'
" Plug 'larsbs/vimterial'
" Plug 'ajh17/Spacegray.vim'
call plug#end()


"=====[ Basic ]=====
let mapleader = "\<Space>"
set number                              " line's number
set rnu                                 " relative numbers
set shortmess=a                         " avoiding the HIT ENTER to continue
set scrolloff=5                         " how many lines you can see then scrolling
set hidden                              " change buffer without saving(!) current
set splitbelow                          " vertical split open below
set splitright                          " horizontal split open right
set nohlsearch                          " search results without highlights
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set guioptions-=L                       " remove scrollbar LEFT
set guioptions-=m                       " remove menu
set guioptions-=r                       " remove scrollbar RIGHT
set guioptions-=T                       " remove toolbar
set guioptions-=e                       " remove GUI tabs, use terminal tabs
syntax on                               " disable/enable syntax
set backspace=indent,eol,start          " fix backspace on my machine
set noerrorbells visualbell t_vb=       " turn off error sound
autocmd GUIEnter * set visualbell t_vb= " turn off error sound

set nobackup
set nowritebackup
set noswapfile

set expandtab 
" set softtabstop=0 
set tabstop=2 
set shiftwidth=2


"=====[ Open/search files in working directory ]=====
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*,.sass-cache/*,.git/*
set wildignore+=prepros.cfg

nnoremap <leader>f :e **/*
nnoremap <leader>v :sp **/*
nnoremap <leader>h :vsp **/*
nnoremap <leader>t :tabe **/*
nnoremap <leader>F :e <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>S :sp <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>V :vsp sfind <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>T :tabe <C-R>=expand('%:h').'/'<CR>

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', 'Rakefile', '.ctrlp', '.tern-project', 'index.html', '.root']

" set path=.,**
" set path +=./**
" set autochdir
" set wildcharm=<C-z>


"=====[ Fonts (render settings) ]=====
" set guifont=Hack:h11
set guifont=Iosevka:h12
" set guifont=Inconsolata:h14

if has("win32")
  set renderoptions=type:directx,gamma:1.0,contrast:0.2,level:1.0,geom:1,renmode:5,taamode:1
endif


"=====[ Colorscheme/themes ]=====
colorscheme Flatcolor
" colorscheme atom-dark
" colorscheme iceberg
" colorscheme onedark
" colorscheme vimterial
" colorscheme Spacegray


"=====[ Plugins settings ]=====

"====={ t9md/vim-choosewin }=====
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

"====={ mattn/emmet-vim }=====
let g:user_emmet_expandabbr_key = '<a-space>'
let g:user_emmet_mode='i' 
let g:user_emmet_install_global = 0

"====={ Valloric/YouCompleteMe }=====
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:ycm_key_list_accept_completion = ['<C-y>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"====={ SirVer/ultisnips }=====
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/vimfiles/plugged/ultisnips/UltiSnips"

"====={ kkoenig/wimproved.vim }=====
autocmd GUIEnter * silent! WCenter
nnoremap <F9> :WCenter<cr>

"====={ easymotion/vim-easymotion }=====
let g:EasyMotion_smartcase = 0
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>;1234567890'
map <Leader> <Plug>(easymotion-prefix)
map <Leader><Leader> <Plug>(easymotion-s)
" map <Leader><Leader> <Plug>(easymotion-overwin-f)
" nnoremap <Leader><Leader>f <Plug>(easymotion-overwin-f)

"====={ scrooloose/nerdtree }=====
nnoremap <F8> :NERDTreeToggle<cr>
nnoremap <silent> <Leader>e :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists(“s:std_in”) | NERDTree | endif
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

"====={ Xuyuanp/nerdtree-git-plugin }=====
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


"=====[ Mapping ]=====

nnoremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

if has("win32")
  nnoremap <silent> <F5> :update<Bar>silent !start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "file://%:p"<CR>
endif


"=====[ Improve defaults / Functions ]=====

"start insert with indent if line was indented
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_cc"
  else
    return "a"
  endif
endfunction
nnoremap <expr> a IndentWithI()

"Disable automatic comments insert
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Create directory if not exist then saving files
fun! <SID>AutoMakeDirectory()
  let s:directory = expand("<afile>:p:h")
  if !isdirectory(s:directory)
    call mkdir(s:directory, "p")
  endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

" Vim size (line, columns)
if has("gui_running")
  set lines=37 columns=130
endif