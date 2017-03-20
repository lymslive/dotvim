" Full custom vimrc
" lymslive 2016-01-22

let g:AppMode = "FullEditor"

" Normal Settings: "{{{1

set nocompatible
syntax on
set t_Co=256
set background=dark
colorscheme peaksea
" colorscheme darkblue

set ruler
"set number
set showcmd	
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu

"Set 3 lines to the curors - when moving vertical..
set scrolloff=3
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
"set virtualedit=all
" Want to be able to use <Tab> within our mappings
set wildcharm=<Tab>
" Recognise key sequences that start with <Esc> in Insert Mode
" set esckeys

set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
" set tabstop=4

set display=lastline
set textwidth=78
set formatoptions+=mB

set autowriteall
" auto cd to current files (or use: au-event-bufEnter "lcd %:p:h")
set autochdir
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
"set fileformats=dos,unix

set cmdheight=2
set laststatus=2
set statusline=%t%m%r%h%w\ %{&ff}\-%Y\ 0x\%B\|\%b\ (%l,%v)\ %p%%%LL
" Custom TabLine is only set when another Tabpage created.
" set tabline=%!CustTabLine()
set cursorline
"set cursorcolumn
set foldmethod=marker

" set clipboard+=unnamed
" set mouse=a
set selection=inclusive

set nobackup
set backupdir=~/tmp/vimbak,.
set history=50
set sessionoptions=tabpages,curdir,slash
set switchbuf=usetab

" let default value ok, wait 1 second
" set timeout
" set nottimeout

" Maps: "{{{1
" Load packed maps
source $VIMHOME/start/remap.vim

" Load Plugin: "{{{1
set rtp+=$VIMHOME/pack/lymslive/opt/vimloo
set rtp+=$VIMHOME/pack/lymslive/opt/EDvsplit
set rtp+=$VIMHOME/pack/lymslive/opt/UseTabpge
set rtp+=$VIMHOME/pack/lymslive/opt/MicroCommand
set rtp+=$VIMHOME/pack/lymslive/opt/Wrap
set rtp+=$VIMHOME/pack/lymslive/opt/vnote
filetype plugin indent on

source $VIMRUNTIME/macros/matchit.vim

" Auto Event Command: {{{1
augroup vimrcEx "
    au!
    " Restore the last positon when close
    autocmd! BufReadPost *
	    \ if line("'\"") > 0 && line("'\"") <= line("$") |
	    \   execute "normal! g`\"" |
	    \ endif

    " When write files to noexists path, make the necessary directory.
    " Seems not work
    autocmd! BufWritePre *
        \if !isdirectory(expand("%:p:h") |
        \  call mkdir(expand("%:p:h"), "p")
        \endif
augroup END

" When Entering the Command window, redefine the <Enter> keyboard locally
augroup CmdWindow
    au!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" YouCompleteMe: {{{1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=3
let g:ycm_seed_identifiers_with_syntax=1

" Ultisnips: {{{1
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEnableSnipMate = 1

