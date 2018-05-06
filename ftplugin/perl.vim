" perl filetype plugin
" Language:	perl
" Maintainer:	lymslive
" Last Change:	2016-01-12

" 注释块
let maplocalleader = ","
nnoremap <buffer> <LocalLeader>x <ESC>:call wraptext#func#wrap('# ', '', "n")<CR>
vnoremap <buffer> <LocalLeader>x <ESC>:call wraptext#func#wrap('# ', '', "v")<CR>

" 语法检查
nnoremap <buffer> <F9> :!perl -c %<CR>

finish
