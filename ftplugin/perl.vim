" perl filetype plugin
" Language:	perl
" Maintainer:	lymslive
" Last Change:	2018-05-16

if exists("b:dotvim_ftplugin_perl")
    finish
endif
let b:dotvim_ftplugin_perl = 1

" 插件加载与配置
PI useperl
silent! nmap <buffer> <unique> K <Plug>(perldoc)

" 注释块
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('# ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('# ', '', "v")<CR>

" 语法检查
compiler perl
nnoremap <buffer> <F9> :make<CR>

" 字典补全
setlocal dictionary+=~/.vim/dict/perl.dic


finish
