" File: vim-log
" Author: lymslive
" Description: use vim as log viewer
" Create: 2018-07-10
" Modify: 2018-07-10

" Common Vimrc:
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

" Load Plugin:
packadd vimloo
packadd autoplug
call autoplug#load()
PI tailflow usetabpg microcmd
filetype plugin indent on
