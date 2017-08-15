" xml filetype plugin
" Language:	xml
" Maintainer:	lymslive
" Last Change:	2014-3-30

" 注释块
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('<!-- ', ' -->', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('<!-- ', ' -->', "v")<CR>

" 按标签移动
" [[ 上一个尖括号，]] 下一个尖括号
nnoremap <buffer> [[ b:call search('<\a\+', 'b')<CR>l
nnoremap <buffer> ]] :call search('<\a\+',)<CR>l
" 移动到上一层开标签
nnoremap <buffer> [< :call <SID>MoveLastOpenTag()<CR>

" see `help insert.txt` for xmlcomplete
let b:TagMotion = []
function! s:MoveLastOpenTag() " {{{1
    normal! b
    let l:tag = xmlcomplete#GetLastOpenTag("b:TagMotion")
    if len(l:tag) > 0
        call search('<' . l:tag, 'b')
    endif
endfunction
finish
