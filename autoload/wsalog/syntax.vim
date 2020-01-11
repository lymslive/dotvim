" File: syntax
" Author: lymslive
" Description: syntax highlight for wsalog
" Create: 2020-01-10
" Modify: 2020-01-10

" Func: #run 
function! wsalog#syntax#run() abort
    syntax keyword Error FAILED
    syntax match PreProc /^\[[-= A-Z]\+\]/ contains=Error
    syntax match Comment /^Note: .*$/

    syntax match Statement /^+\+\s*\zs.*$/
endfunction
