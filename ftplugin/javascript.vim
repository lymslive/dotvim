
" 直接用大括号折叠
set foldmarker={,}

" 跳转函数定义头
nnoremap [[ :call search('\<function\(\s\+\w\+\s*\)\?(.*)', 'bW')<CR>^
nnoremap ]] :call search('\<function\(\s\+\w\+\s*\)\?(.*)', 'W')<CR>$

nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>
