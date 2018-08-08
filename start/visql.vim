" File: vim.vim
" Author: lymslive
" Description: server as vimrc for mysql $EDITOR
" Create: 2017-03-25
" Modify: 2017-08-15

" Common Vimrc:
" set nocompatible
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim

" 载入字典补全
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 3
packadd neocomplete.vim
if exists('$MYSQL_DBDIC')
    set dict+=$MYSQL_DBDIC
endif

packadd ultisnips
packadd vim-snippets
filetype plugin indent on

augroup VISQL
    autocmd!
    " 临时文件设为 sql 
    autocmd! BufNew * set filetype=sql
augroup END

" 直接进入编辑模式
startinsert
