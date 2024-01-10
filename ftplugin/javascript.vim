
" 直接用大括号折叠
set foldmarker={,}
set foldlevelstart=2
setlocal foldlevel=2

" 跳转函数定义头
nnoremap <buffer> [[ :call search('\<function\(\s\+\w\+\s*\)\?(.*)', 'bW')<CR>^
nnoremap <buffer> ]] :call search('\<function\(\s\+\w\+\s*\)\?(.*)', 'W')<CR>$

" 跳转对象定义 object: {
nnoremap <buffer> [o :call search('\w\+\s*:\s*{\s*$', 'bW')<CR>^
nnoremap <buffer> ]o :call search('\w\+\s*:\s*{\s*$', 'W')<CR>$

nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>

" 加载一次插件
if !exists('s:plugin')
    let s:plugin = 1
    packadd tern_for_vim
endif

" 定义插件的快捷键
if exists(':TernDoc')
    nnoremap <buffer> <C-]> :TernDef<CR>
    nnoremap <buffer> <C-\>c :TernRefs<CR>
    nnoremap <buffer> <C-\>t :TernType<CR>
endif
