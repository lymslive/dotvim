" File: curl
" Author: lymslive
" Description: get log text by curl
" Create: 2019-12-30
" Modify: 2019-12-30

" Func: #run 
function! wsalog#curl#run(...) abort
    if a:0 > 0 && !empty(a:1)
        let l:url = a:1
    else
        let l:url = getline('.')
    endif
    if empty(l:url)
        return
    endif
    let l:url = escape(l:url, '%#')
    execute 'read !curl -s' l:url
endfunction

" Func: #asynrun 
function! wsalog#curl#asyncrun(...) abort
    if a:0 > 0 && !empty(a:1)
        let l:url = a:1
    else
        let l:url = getline('.')
    endif
    if empty(l:url)
        return
    endif
    let l:job = wsalog#CJenkins#new(l:url, 'c:\Users\tans2\home\jklogs')
    call l:job.log_download()
endfunction
