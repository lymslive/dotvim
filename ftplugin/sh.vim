" perl filetype plugin
" Language:	shell bash
" Maintainer:	lymslive
" Last Change:	2011-10-19

set shiftwidth=4	" 自动缩进4空格
set softtabstop=4	" Tab 宽度为4
set formatoptions-=t	" 代码不自动折行
set formatoptions+=ro

" 注释块
let mapleader = ","
nnoremap <buffer> <leader>x <ESC>:call Wrap#Wrap('# ', '', "n")<CR>
vnoremap <buffer> <leader>x <ESC>:call Wrap#Wrap('# ', '', "v")<CR>

" 设置脚本可执行 
nnoremap <buffer> <F10> <ESC>:!chmod a+x %<CR>

finish
