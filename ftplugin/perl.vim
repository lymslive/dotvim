" perl filetype plugin
" Language:	perl
" Maintainer:	lymslive
" Last Change:	2018-05-16

if exists("b:dotvim_ftplugin")
    " finish
endif
let b:dotvim_ftplugin = 1

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal noexpandtab

" 插件加载与配置
PI useperl
silent! nmap <buffer> <unique> K <Plug>(perldoc)

" 注释块
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('# ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('# ', '', "v")<CR>

" 语法检查
compiler perl
nnoremap <buffer> <F9> :make<CR>
" 当前文件 pod 检测
nnoremap <buffer> <F10> :!podchecker %<CR>
" 运行当前文件，停留在命令行，等待额外参数
nnoremap <buffer> <F5> :!perl %

" 字典补全
setlocal dictionary+=~/.vim/dict/perl.dic

setlocal foldmarker={,}
setlocal foldmethod=marker

" SEE: vim-perl plugin
let g:perl_fold = 1
let g:perl_fold_blocks = 1
setlocal foldlevelstart=3

finish
