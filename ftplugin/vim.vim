" Vim filetype plugin
" Language:	Vim
" Maintainer: lymslive
" Modify: 2017-03-23

" 常规设置 "{{{1
" always use space to indent
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

setlocal dictionary=~/.vim/dict/vim.dic

" 运行脚本
nnoremap <buffer> <F5> :update<CR>:source %<CR>
vnoremap <buffer> <F5> :call <SID>RunLines()<CR>
function! s:RunLines() "{{{
    let l:line = getline('.')
    execute l:line
endfunction "}}}

" 重新加载并测试脚本
nnoremap <buffer> <F9> :update<CR>:source %<CR>:ClassTest

" 为正则表达式添加括号分组 \(\)
vnoremap <buffer> ,) <ESC>:call Wrap#Wrap('\(', '\)', "v")<CR>
" 注释块
nnoremap <buffer> ,x <ESC>:call Wrap#Wrap('" ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call Wrap#Wrap('" ', '', "v")<CR>

inoremap <buffer> " "

" 查看帮助
nnoremap <buffer> K :help expand('<cword>')<CR>

" 折叠设置 "{{{1
setlocal foldmethod=marker
" 添加简版 1234 级折叠
nnoremap <buffer> z1 A<Space><C-r>=substitute(&commentstring, '%s', split(&foldmarker, ',')[0].'1', '')<CR><Esc>
nnoremap <buffer> z2 A<Space><C-r>=substitute(&commentstring, '%s', split(&foldmarker, ',')[0].'2', '')<CR><Esc>
nnoremap <buffer> z3 A<Space><C-r>=substitute(&commentstring, '%s', split(&foldmarker, ',')[0].'3', '')<CR><Esc>
nnoremap <buffer> z4 A<Space><C-r>=substitute(&commentstring, '%s', split(&foldmarker, ',')[0].'4', '')<CR><Esc>

if !exists('s:once')
    set rtp+=$PACKHOME/Shougo/opt/neco-vim
    silent source $PACKHOME/Shougo/opt/neco-vim/plugin/necovim.vim
endif
finish
