if exists("b:did_quickfix")
  finish
endif
let b:did_quickfix = 1

noremap <buffer> q <C-W>c
noremap <buffer> <CR> <CR>

noremap <buffer> <Space> <CR><C-W>p
noremap <buffer> J j<CR><C-W>p
noremap <buffer> K k<CR><C-W>p

noremap <buffer> / :cclose<CR>:CM -- clist<CR>

" --------------------------------------------------------------------------------
"  global mapping load once

if exists("s:did_quickfix")
    finish
endif
let s:did_quickfix = 1
:nnoremap <C-n> :cn<CR>
:nnoremap <C-p> :cp<CR>
