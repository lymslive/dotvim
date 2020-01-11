command! -nargs=? Curl call wsalog#curl#run(<f-args>)
command! -nargs=? WSALog call wsalog#curl#asyncrun(<f-args>)

augroup WSALOG_GLOBAL
    autocmd!
    autocmd BufReadPost *.log,*.LOG call wsalog#buffer#detect()
augroup END

" Func: #load 
function! wsalog#plugin#load() abort
    return 1
endfunction
