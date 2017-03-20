" File: vcide
" Author: lymslive
" Description: vimrc for coder
" Create: 2017-03-20
" Modify: 2017-03-20
let g:AppMode = "VCIDE"

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
set wildmenu
" set ignorecase
set smartcase
set tagcase=match

set wildignore=*.o,*.obj,*.out,.svn/*,.git/*

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
" set softtabstop=4
set tabstop=4

set nowrap
set display=lastline
set textwidth=78
set formatoptions+=mB
set formatoptions-=t

set autowriteall
" auto cd to current files (or use: au-event-bufEnter "lcd %:p:h")
set autochdir
set autoread
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
set fileformats=unix,dos

set cmdheight=2
set laststatus=2
" :help 'statusline'
" set statusline=%t%m%r%h%w\ %{&ff}\-%Y\ 0x\%B\|\%b\ (%l,%v)\ %p%%%LL
" set statusline=%t%m%r%h%w\ %{&ff}\-%Y\ (%l,%v)\ %p%%%LL%=%{&fenc}\ 0x\%B\|\%b\ 
set statusline=%t%m%r%h%w:%l\|%v\ %{&ff}\-%Y\ %p%%%LL%=%{&fenc}\ 0x\%B\|\%b\ 
" Custom TabLine is only set when another Tabpage created.
" set tabline=%!CustTabLine()
set cursorline
"set cursorcolumn
set foldmethod=syntax

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
" Load helper script
source $VIMHOME/mine/PlugManage.vim
source $VIMRUNTIME/macros/matchit.vim

let $PACKHOME = $VIMHOME . '/pack'

" 手动添加本地个人插件
set rtp+=$PACKHOME/lymslive/opt/vimloo
set rtp+=$PACKHOME/lymslive/opt/EDvsplit
set rtp+=$PACKHOME/lymslive/opt/UseTabpge
set rtp+=$PACKHOME/lymslive/opt/qcmotion
set rtp+=$PACKHOME/lymslive/opt/Spacebar
set rtp+=$PACKHOME/lymslive/opt/MicroCommand
set rtp+=$PACKHOME/lymslive/opt/Wrap
set rtp+=$PACKHOME/lymslive/opt/logview
set rtp+=$PACKHOME/lymslive/opt/vnote

set rtp+=$PACKHOME/VundleVim/opt/Vundle.vim
set rtp+=$PACKHOME/tpope/opt/vim-surround
set rtp+=$PACKHOME/kshenoy/opt/vim-signature
set rtp+=$PACKHOME/scrooloose/opt/nerdtree
set rtp+=$PACKHOME/majutsushi/opt/tagbar

set rtp+=$PACKHOME/SirVer/opt/ultisnips
set rtp+=$PACKHOME/honza/opt/vim-snippets
" set rtp+=$PACKHOME/Shougo/opt/neosnippet
" set rtp+=$PACKHOME/Shougo/opt/neosnippet-snippets

set rtp+=$PACKHOME/Shougo/opt/vimproc.vim
set rtp+=$PACKHOME/Shougo/opt/vimshell.vim
set rtp+=$PACKHOME/Shougo/opt/unite.vim
set rtp+=$PACKHOME/Shougo/opt/neoyank.vim
set rtp+=$PACKHOME/Shougo/opt/neomru.vim
set rtp+=$PACKHOME/Shougo/opt/unite-outline
set rtp+=$PACKHOME/Shougo/opt/unite-help
set rtp+=$PACKHOME/Shougo/opt/neoinclude.vim
set rtp+=$PACKHOME/tsukkee/opt/unite-tag
set rtp+=$PACKHOME/amitab/opt/vim-unite-cscope

set rtp+=$PACKHOME/Shougo/opt/neocomplete.vim
" set rtp+=$PACKHOME/Valloric/opt/YouCompleteMe
set rtp+=$PACKHOME/Rip-Rip/opt/clang_complete

set rtp+=$PACKHOME/mileszs/opt/ack.vim
" set rtp+=$PACKHOME/asins/opt/vim-dict
set rtp+=$PACKHOME/haya14busa/opt/incsearch.vim

filetype plugin indent on

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
        \  call mkdir(expand("%:p:h"), "p") |
        \endif
augroup END

" When Entering the Command window, redefine the <Enter> keyboard locally
augroup CmdWindow
    au!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" Special Evironment: {{{1
source $VIMHOME/start/plug_cide.vim
