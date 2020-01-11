" File: gvim.vim
" Author: lymslive
" Description: server as vimrc for `gvim` only
" Create: 2019-10-10
" Modify: 2019-10-10

" Common Vimrc:
" set nocompatible
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

set guioptions-=T
set guioptions-=e
set guioptions-=m
set clipboard=unnamed
set winaltkeys=no

set shellcmdflag=/d\ /s\ /c
set noshelltemp

set guifont=DejaVu_Sans_Mono:h10:cANSI:qDRAFT

" Load Plugin:
packadd matchit
" packadd StartVim
packadd vimloo
packadd autoplug
call autoplug#load()
PI edvsplit microcmd usetabpg wraptext

filetype plugin indent on

" read .vimrc in current directory
set exrc
" set secure
