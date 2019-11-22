" File: vim.vim
" Author: lymslive
" Description: server as vimrc for `gvim` only
" Create: 2019-11-20
" Modify: 2019-11-20

" Common Vimrc:
" set nocompatible
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

set guifont=Lucida_Console:h12:cANSI:qDRAFT
set guioptions=
set clipboard=unnamed

" Load Plugin:
" packadd StartVim
packadd vimloo
packadd autoplug
call autoplug#load()
PI usetabpg microcmd
filetype plugin indent on
