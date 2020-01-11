" File: buffer
" Author: lymslive
" Description: command local in waslog file
" Create: 2020-01-07
" Modify: 2020-01-07

" Func: #nextlog 
function! wsalog#buffer#nextlog(shift, ...) abort
    let l:obj = s:get_jenkins_obj()
    if empty(l:obj)
        echomsg 'seams not a wsalog from jenkins'
        return
    endif
    let l:number = 0
    if a:0 > 0 && !empty(a:1)
        let l:number = a:1
    else
        if a:shift ==# '+'
            let l:number = l:obj.jobnumber + 1
        elseif a:shift ==# '-'
            let l:number = l:obj.jobnumber - 1
        endif
    endif
    if l:number <= 0
        echomsg 'invalid jobnumber'
    endif
    let l:newObj = l:obj.switch_number(l:number)
    call l:newObj.log_download()
endfunction

" Func: s:get_jenkins_obj 
function! s:get_jenkins_obj() abort
    if exists('b:Jenkins') && !empty(b:Jenkins)
        return b:Jenkins
    endif
    return wsalog#CJenkins#newFromBuffer()
endfunction

" Func: #init 
function! wsalog#buffer#init(obj) abort
    let b:Jenkins = a:obj
    setlocal filetype=wsalog
    command! -buffer -count=0 LogNext call wsalog#buffer#nextlog('+', <count>)
    command! -buffer -count=0 LogPrev call wsalog#buffer#nextlog('-', <count>)
    call wsalog#syntax#run()
endfunction

" Func: #detect 
function! wsalog#buffer#detect() abort
    if exists('b:Jenkins') && !empty(b:Jenkins)
        return
    endif
    let l:obj = s:get_jenkins_obj()
    if !empty(l:obj)
        call wsalog#buffer#init(l:obj)
    endif
endfunction
