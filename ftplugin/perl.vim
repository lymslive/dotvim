" perl filetype plugin
" Language:	perl
" Maintainer:	lymslive
" Last Change:	2018-05-16

if exists("b:dotvim_ftplugin")
    finish
endif
let b:dotvim_ftplugin = 1

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal noexpandtab

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

" Load Plugins:
" 插件加载与配置
" PI useperl
if !exists("s:dotvim_ftplugin")
    let s:dotvim_ftplugin = 1

    packadd vim-perl
    " see {vim-perl}/syntax/perl.vim
    let g:perl_fold = 0
    let g:perl_fold_blocks = 0
    let g:perl_nofold_packages = 1

    packadd useperl
    " command abbreviation
    cabbrev PP PerlPrint
    cabbrev PS PerlSearch

endif

" 处理大文件折叠
let s:iLargeFile = 1024 * 100
let b:iSize = getfsize(expand('%:p'))
if (b:iSize > s:iLargeFile || b:iSize == -2) " && &foldmethod ==? 'syntax'
    setlocal foldmethod=manual
else
    setlocal foldmethod=syntax
endif
setlocal foldlevelstart=3
call useperl#ftplugin#load()

finish
