" vim-plug {{{
call plug#begin()
" Main
Plug 'airblade/vim-rooter'
Plug 'mattn/emmet-vim',        { 'for': ['html','xhtml','css','sass','scss','xml'] }
Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py --all' }
Plug 'SirVer/ultisnips'   | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
" Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'szw/vim-maximizer', { 'on': ['MaximizerToggle'] }
Plug 'lyokha/vim-xkbswitch'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-projectionist'
Plug 'kshenoy/vim-signature'
Plug 'mtth/scratch.vim'
Plug 'vimwiki/vimwiki'
" Plug 'vim-syntastic/syntastic'


" Splits, windows, explorers
Plug 'scrooloose/nerdtree', { 'on':  [ 'NERDTreeToggle', 'NERDTreeFind' ] } " F8 / <leader>e 
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zhaocai/GoldenView.Vim' " , { 'on': [ 'GoldenViewSplit' ] }

" Syntax
Plug 'sheerun/vim-polyglot'

" Other
Plug 'jiangmiao/auto-pairs'      " alt-a / ctrl-v to disable in insert mode
Plug 't9md/vim-choosewin'        " S to choose window
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'   " ga
Plug 'kkoenig/wimproved.vim'     " F9 to center window
Plug 'easymotion/vim-easymotion' " <leader><leader>
Plug 'machakann/vim-highlightedyank'
" Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession' | Plug 'gikmx/ctrlp-obsession'
Plug 'xolox/vim-session' 
Plug 'xolox/vim-misc'

" For future research
Plug 'tpope/vim-fugitive'
" Plug 'kien/ctrlp.vim'
Plug 'ctrlpvim/ctrlp.vim' " , { 'on': [ 'CtrlP' ] }
" Plug 'wincent/command-t'
" Plug 'Valloric/MatchTagAlways', { 'for': ['html'] }
" buildcomposer {{{
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
"}}}
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" Plug 'maxbrunsfeld/vim-yankstack'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'metakirby5/codi.vim' " Not working on windows now, check it later
" Plug 'jaxbot/semantic-highlight.vim'
" Plug 'AndrewRadev/splitjoin.vim'
Plug 'michaeljsmith/vim-indent-object'

" Colorschemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'MaxSt/FlatColor'
Plug 'reedes/vim-colors-pencil'
" Plug 'cocopon/iceberg.vim'
" Plug 'larsbs/vimterial'
" Plug 'ajh17/Spacegray.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'kabbamine/yowish.vim'
call plug#end()
" }}}


" Basic {{{
let mapleader = "\<Space>"
let maplocalleader = "\\"
" set textwidth=70
set nowrap
set shortmess+=c                        " User defined completion (^U^N^P) not work :)
set number                              " line's number
" set rnu                                 " relative numbers
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
" set clipboard^=unnamedplus,unnamed

set nobackup
set nowritebackup
set noswapfile

set undofile
set undodir=~/vimfiles/.undo//
" set directory=~/vimfiles/.swp//
" set backup
" set backupdir=~/vimfiles/.backup//

" https://dev-mark.blogspot.ru/2010/12/vim.html
set expandtab       " tabs are spaces
" set softtabstop=0 " number of spaces in TAB when editing
set tabstop=2       " numer of visual spaces per TAB

set shiftwidth=2
" }}}


" Open/search files in working directory {{{
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
" comment next line because using Ag(silver searcher) ~/.agignore
" set wildignore+=node_modules/*,bower_components/*,.sass-cache/*,.git/*,_production/*,public/*
set wildignore+=prepros.cfg

nnoremap <leader>f :e **/*
nnoremap <leader>v :sp **/*
nnoremap <leader>h :vsp **/*
nnoremap <leader>t :tabe **/*
nnoremap <leader>F :e <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>V :sp <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>H :vsp sfind <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>T :tabe <C-R>=expand('%:h').'/'<CR>

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', 'Rakefile', 'index.html']

" https://github.com/neovim/neovim/issues/3209
" set path=.,**
" set path +=.,
" set path +=./js/**
" set path +=./sass/**
" set autochdir
" set wildcharm=<C-z>
" }}}


" Fonts (render settings) {{{
" set guifont=Hack:h11
" set guifont=Hack:h16
" set guifont=Iosevka:h12
" set guifont=Iosevka:h17
" set guifont=Inconsolata:h11
" set guifont=Inconsolata:h16
" set guifont=Pt_Mono:h11
" set guifont=Pt_Mono:h15
set guifont=Anonymous_Pro:h11
" set guifont=Anonymous_Pro:h16

if has("win32")
  set renderoptions=type:directx,gamma:1.0,contrast:0.2,level:1.0,geom:1,renmode:5,taamode:1
endif
" }}}


" Colorscheme/themes {{{
" colorscheme PaperColor
  " colorscheme pencil
  " colorscheme onedark
  colorscheme yowish

  " set termguicolors
  " let ayucolor="light" "mirage, dark
  " colorscheme ayu


" colorscheme Flatcolor

" colorscheme atom-dark
" colorscheme iceberg
" colorscheme vimterial
" colorscheme Spacegray

" set background=light
set background=dark
" }}}


" Plugins settings {{{
"====={ t9md/vim-choosewin }=====
nmap S <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_label = 'iojklfdsa'
" let g:choosewin_tablabel = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

"====={ mattn/emmet-vim }=====
let g:user_emmet_expandabbr_key = '<a-space>'
let g:user_emmet_mode='i' 

"====={ Valloric/YouCompleteMe }=====
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:ycm_key_list_accept_completion = ['<C-y>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"====={ SirVer/ultisnips }=====
  " let g:UltiSnipsExpandTrigger="<Tab>"
  " if !exists("g:UltiSnipsJumpForwardTrigger")
  "   let g:UltiSnipsJumpForwardTrigger = "<tab>"
  " endif
  " " let g:UltiSnipsJumpForwardTrigger="<c-j>"
  " let g:UltiSnipsJumpBackwardTrigger="<S-Tab"
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/vimfiles/plugged/ultisnips/UltiSnips"

"====={ kkoenig/wimproved.vim }=====
autocmd GUIEnter * silent! WCenter
nnoremap <F9> :WCenter<cr>

"====={ easymotion/vim-easymotion }=====
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>;1234567890'
" map <Leader> <Plug>(easymotion-prefix)
" map <Leader><Leader> <Plug>(easymotion-s)
" one char window
map <cr> <Plug>(easymotion-s)
" two char window 
" map <cr> <Plug>(easymotion-s2)
map f <Plug>(easymotion-bd-fl)
" map s <Plug>(easymotion-s)
" nmap V V<Plug>(easymotion-bd-jk)
" vmap ; <Plug>(easymotion-bd-jk)
" nmap v v<Plug>(easymotion-bd-fl)
" nmap v bv<Plug>(easymotion-bd-fl)

"====={ scrooloose/nerdtree }=====
nnoremap <Leader>e :NERDTreeToggle<cr>
nnoremap <silent> <Leader><s-e> :NERDTreeFind<CR>


let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeMapOpenSplit = 'v'
let NERDTreeMapOpenVSplit = 'h'
let NERDTreeIgnore=['node_modules[[dir]]']

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists(“s:std_in”) | NERDTree | endif
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

"====={ Xuyuanp/nerdtree-git-plugin }=====
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }

"====={ junegunn/vim-easy-align }=====
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"====={ machakann/vim-highlightedyank }=====
map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 300

"====={ zhaocai/GoldenView.Vim }=====
let g:goldenview__enable_at_startup = 0
" 1. split to tiled windows
let g:goldenview__enable_default_mapping = 0
" nmap <c-l> <Plug>GoldenViewSplit:e **/*
" nmap <C-l> <Plug>GoldenViewSplit:CtrlSpace O<CR>
nmap <c-l> <Plug>GoldenViewSplit<c-p>

" 2. quickly switch current window with the main pane
" and toggle back
nmap <silent> <F4>   <Plug>GoldenViewSwitchMain
nmap <silent> <F3> <Plug>GoldenViewSwitchToggle

" 3. jump to next and previous window
" nmap <silent> <a-j>  <Plug>GoldenViewNext
" nmap <silent> <a-k>  <Plug>GoldenViewPrevious

"====={ vim-ctrlspace/vim-ctrlspace }=====
" nnoremap <silent><C-p> :CtrlSpace<CR>

"====={ maxbrunsfeld/vim-yankstack }=====
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste

"====={ jiangmiao/auto-pairs }=====
let g:AutoPairsShortcutToggle = "<a-a>"

"====={ tpope/vim-fugitive }=====
set diffopt+=vertical

" {{====={ kien/ctrlp.vim }=====
" comment next line because using Ag(silver searcher) ~/.agignore
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|_production\|public'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_cmd = 'CtrlP'
" nnoremap <c-p> :CtrlPBuffer<cr>
nnoremap <c-b> :CtrlPBookmarkDir<cr>
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_root_markers = ['.git', 'Rakefile', 'package.json']
" let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
  " let g:ctrlp_max_depth = 10
let g:ctrlp_cache_dir = $HOME.'/vimfiles/.cache/ctrlp'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_arg_map = 0
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': 'test',
      \ 'expanded': '@cd I:\Dropbox\CODE\',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
      \ 'expanded': '.\{-}',
      \ 'mode': 'pfr',
    \ },
    \ {
      \ 'pattern': '\\\@<!:.\+\zs\\\@<! ',
      \ 'expanded': '\ ',
      \ 'mode': 'pfz',
    \ },
    \ ]
  \ }

let g:ctrlp_prompt_mappings = {
      \ 'PrtBS()':              ['<bs>', '<c-]>'],
      \ 'PrtDelete()':          ['<del>'],
      \ 'PrtDeleteWord()':      ['<c-w>'],
      \ 'PrtClear()':           ['<c-u>'],
      \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
      \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
      \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
      \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
      \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
      \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
      \ 'PrtHistory(-1)':       ['<c-n>'],
      \ 'PrtHistory(1)':        ['<c-p>'],
      \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
      \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>', 'c-v'],
      \ 'AcceptSelection("t")': ['<c-t>'],
      \ 'AcceptSelection("v")': ['<c-h>', '<RightMouse>'],
      \ 'ToggleFocus()':        ['<s-tab>'],
      \ 'ToggleRegex()':        ['<c-r>'],
      \ 'ToggleByFname()':      ['<c-d>'],
      \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
      \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
      \ 'PrtExpandDir()':       ['<tab>'],
      \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
      \ 'PrtInsert()':          ['<c-\>'],
      \ 'PrtCurStart()':        ['<c-a>'],
      \ 'PrtCurEnd()':          ['<c-e>'],
      \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
      \ 'PrtCurRight()':        ['<c-l>', '<right>'],
      \ 'PrtClearCache()':      ['<F5>'],
      \ 'PrtDeleteEnt()':       ['<F7>'],
      \ 'CreateNewFile()':      ['<c-m>'],
      \ 'MarkToOpen()':         ['<c-z>'],
      \ 'OpenMulti()':          ['<c-o>'],
      \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
      \ }

let g:ctrlp_mruf_exclude = '^C:\\dev\\tmp\\.*' " Windows
let g:ctrlp_mruf_relative = 0
let g:ctrlp_mruf_case_sensitive = 1
" }}}

"====={ xolox/vim-session }=====
nnoremap <Leader>ss :SaveSession! 
nnoremap <Leader>so :OpenSession! 
nnoremap <Leader>sr :RestartVim!<cr>
" nnoremap <Leader>ss :mksession! ~\vimfiles\sessions\
" nnoremap <Leader>so :silent! source ~\vimfiles\sessions\


"====={ nathanaelkane/vim-indent-guides }=====
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1


"====={ lyokha/vim-xkbswitch }=====
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = 'C:\Program Files (x86)\Vim\vim80_py\libxkbswitch64.dll' 
let g:markdown_composer_autostart = 0

"====={ mtth/scratch.vim }=====
let g:scratch_insert_autohide = 0
let g:scratch_persistence_file = '_scratch.vim'

"====={ vim-syntastic/syntastic }=====
let g:syntastic_javascript_checkers=['eslint']
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" }}}


" Mapping {{{
if has("win32")
  nnoremap <silent> <F5> :update<Bar>silent !start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "file://%:p"<CR>
  nnoremap <F6> :!start explorer /select,%:p<CR>
  nnoremap <silent> <F7> :!start "C:\Program Files\Git\git-bash.exe" -c "npm run gulp"<cr>
  nnoremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

nnoremap <F12> :MaximizerToggle!<cr>

xnoremap <S-Insert> "*p
xnoremap <S-Del> "*y

nnoremap Q @q

nnoremap <silent> "" :registers<cr>
nnoremap M :marks<cr>

nnoremap H ^
vnoremap H ^
nnoremap L g_
vnoremap L g_

nnoremap <a-p> "0p
nnoremap <a-P> "0P
xnoremap <a-p> "0p
xnoremap <a-P> "0P

" nnoremap Y :normal ^yg_<cr>
nnoremap Y :normal yg_<cr>
vnoremap y y']

" nnoremap p ]p']
nnoremap p p=`]`]
vnoremap p p=`]`]
nnoremap P P=`]`]
vnoremap P P=`]`]

" Switching between current and last buffer
nnoremap <Bs> <c-^>

nnoremap j gj
nnoremap k gk

nnoremap ZZ :xa<cr>
nnoremap ZQ :qa!<cr>

" prevent * from jumping to the next match
nnoremap * *<C-o>
" nnoremap *:keepjumps normal! mi*`i<cr>

" last word to upper case
inoremap <c-u> <esc>viwUea

" auto-expanding () {} [] '' "" ``
" inoremap (; (<cr>);<Esc>O
" inoremap (, (<cr>),<Esc>O
" inoremap {; {<cr>};<Esc>O
" inoremap {, {<cr>},<Esc>O
" inoremap [; [<cr>];<Esc>O
" inoremap [, [<cr>],<Esc>O

" go to next argument
" inoremap ,, <esc>la, ''<esc>i
inoremap ,, <esc>la, 
inoremap >>  => 

" }}}


" Improve defaults / Functions {{{
"start insert with indent if line was indented
" function! IndentWithI()
"   if len(getline('.')) == 0
"     return "\"_cc"
"   else
"     return "a"
"   endif
" endfunction
" nnoremap <expr> a IndentWithI()

nnoremap <silent>i @=empty(getline(".")) ? "\"_S" : "i"<cr>
nnoremap <silent>I @=empty(getline(".")) ? "\"_S" : "I"<cr>
nnoremap <silent>a @=empty(getline(".")) ? "\"_S" : "a"<cr>
nnoremap <silent>A @=empty(getline(".")) ? "\"_S" : "A"<cr>


"Create directory if not exist when saving files
fun! <SID>AutoMakeDirectory()
  let s:directory = expand("<afile>:p:h")
  if !isdirectory(s:directory)
    call mkdir(s:directory, "p")
  endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

" Vim size (line, columns)
if has("gui_running")
  set lines=33 columns=130
endif
" }}}


"Vimscript tests"{{{
" map x :echo 'work'<cr>
" unmap x
" imap <c-m> <esc>viW~A
" some_test_variable
" autocmd BufWritePre * command
" autocmd BufNewFile * command
" autocmd BufNewFile,BufWritePre * command
" autocmd BufNewFile,BufWritePre *.html setlocal nowrap
" autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
" :help autocmd-events
"}}}


" autocmd {{{
augroup All
  autocmd!
  autocmd FileType * nnoremap <buffer> <localleader>w :set wrap!<cr>
  "Disable automatic comments insert
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" augroup HTML
  " autocmd!
  " autocmd FileType html nnoremap <buffer> <localleader>w :set wrap!<cr>
  " autocmd FileType html setlocal nowrap
  " autocmd BufNewFile,BufWritePre *.html setlocal nowrap
  " autocmd FileType vim setlocal set nowrap
" augroup END

" augroup Vim
  " autocmd!
  " autocmd FileType vim setlocal foldmethod=marker
  " autocmd BufWritePost *vimrc source $MYVIMRC
  " autocmd BufWinLeave *vimrc mV
" augroup END

augroup Html
  autocmd!
  autocmd FileType html nnoremap <buffer> <silent> <leader>i :w<cr>:!npm start<cr>
augroup END

augroup Python
  autocmd!
  autocmd FileType python nnoremap <buffer> <silent> <leader>i :w<cr>:!python3 %<cr><cr>
  " autocmd FileType python nnoremap <buffer> <silent> <leader>I :w<cr>:!python3 | clip %<cr><cr>
augroup END

augroup Wiki
  autocmd!
  autocmd FileType javascript.wiki set syntax=javascript
  autocmd FileType *ruby*.wiki set syntax=ruby
  autocmd FileType python.wiki set syntax=python
  autocmd FileType bash.wiki set syntax=bash
  autocmd FileType c.wiki set syntax=c
augroup END

augroup Ruby
  autocmd!
  autocmd FileType ruby nnoremap <buffer> <silent> <leader>i :w<cr>:!ruby %<cr><cr>
augroup END

augroup Javascript
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>i :w<cr>:!node %<cr><cr>
augroup END

augroup Markdown
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>i :ComposerStart<cr>
  autocmd FileType md nnoremap <buffer> <silent> <leader>p :ComposerStart<cr>
augroup END



" }}}


" User commands"{{{
command! Night colorscheme onedark | set background=dark | syntax on | syntax sync fromstart
command! Flat colorscheme flatcolor | set background=dark | syntax on | syntax sync fromstart
command! Day colorscheme PaperColor | set background=light | syntax on | syntax sync fromstart
command! BigFont set guifont=Hack:h16
command! SmallFont set guifont=Anonymous_Pro:h11
command! Vim :tabe I://Dropbox/dotfiles/_vimrc
"}}}
