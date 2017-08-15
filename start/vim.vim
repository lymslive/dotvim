" File: vim.vim
" Author: lymslive
" Description: server as vimrc for `vim` only
" Create: 2017-03-25
" Modify: 2017-08-15

" Common Vimrc:
" set nocompatible
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

" Load Plugin:
packadd StartVim
packadd vimloo
packadd autoplug
call autoplug#load()
filetype plugin indent on
