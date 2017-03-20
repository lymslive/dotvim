" perl filetype plugin
" Language:	perl
" Maintainer:	lymslive
" Last Change:	2016-01-12

" 注释块
let maplocalleader = ","
nnoremap <buffer> <LocalLeader>x <ESC>:call Wrap#Wrap('# ', '', "n")<CR>
vnoremap <buffer> <LocalLeader>x <ESC>:call Wrap#Wrap('# ', '', "v")<CR>

finish
