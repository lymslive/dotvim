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
packadd neocomplete.vim
if exists('$MYSQL_DBDIC')
    set dict+=$MYSQL_DBDIC
endif
NeoCompleteEnable

filetype plugin indent on

augroup VISQL
    autocmd!
    " 临时文件设为 sql 
    autocmd! BufNew /tmp/* set filetype=sql
augroup END

" 直接进入编辑模式
startinsert
