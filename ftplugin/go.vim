" Vim filetype plugin
" Language:	go
" Maintainer: lymslive
" Modify: 2018-04-21

if !exists('s:once')
    let s:once = 1
    packadd vim-go
endif

setlocal tabstop=4
setlocal shiftwidth=4

nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>
