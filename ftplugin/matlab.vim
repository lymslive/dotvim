" Vim filetype plugin file of mine
" Language:	matlab
" Maintainer:	lymslive
" Last Changed: 2009-12-25


set showmatch	" 显示配对括号
"set cin		" V选中一段文本后，可用“=”重新调整缩进
"set guioptions+=b	" 添加水平滚动条

" 折叠设置 {{{
set foldmethod=syntax	" 按缩进折叠
set foldcolumn=0	" 显示折叠边

" 这个函数将就适用
if !exists("MatlabFoldfun_loaded")
function MatlabFoldfun(lnum)
    " 关键词增加一层折叠
    if getline(a:lnum) =~ '^\s*\(if\|for\|while\|function\|classdef\|properties\|methods\|try\)\s\+'
	return "a1"
    " end 标记关闭该层折叠
    elseif getline(a:lnum) =~ '^\s*end\s*'
	return "s1"
    else
	return "="
    endif
endfunction " of MatlabFoldfun definition
let MatlabFoldfun_loaded = 1
endif " of exists MatlabFoldfun

set foldmethod=expr 
set foldexpr=MatlabFoldfun(v:lnum) 
set foldlevel=2
" end of flod setting }}}

" Shift-Enter 不算定添加注释前缀
inoremap <buffer> <S-CR> <CR><Esc>C
" 注释块
nnoremap <buffer> ,x <ESC>:call Wrap#Wrap('% ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call Wrap#Wrap('% ', '', "v")<CR>

" 添加括号
" iabbrev <buffer> [ []<left>
" iabbrev <buffer> ( ()<left>
" iabbrev <buffer> { {}<left>

" EOF vim:fdm=marker:
