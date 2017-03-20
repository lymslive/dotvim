"===============================================================================
"
"          File:  qf.vim
" 
"   Description:  
" 
"   VIM Version:  7.0+
"        Author:  
"  Organization:  
"       Version:  
"       Created:  
"       License:  
"===============================================================================
"
" Only do this when not done yet for this buffer
"
if exists("b:did_quickfix")
  finish
endif
let b:did_quickfix = 1

noremap <buffer> q <C-w>c
" noremap <buffer> <Space> :cc<CR>
noremap <buffer> <Space> <CR>
noremap <buffer> <CR> <CR>
