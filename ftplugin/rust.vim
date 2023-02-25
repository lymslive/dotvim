" Vim filetype plugin file of mine
" Language:	rust
" Maintainer:	lymslive
" Last Changed: 2023-02-25

if exists("b:did_ftplugin") && b:did_ftplugin
    finish
endif

" 注释
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
