" File: search
" Author: lymslive
" Description: search using perl style regexp
" Create: 2018-08-16
" Modify: 2018-08-16

command! -nargs=* PerlSearch call useperl#search#Commander(<f-args>)

let s:ifperl = useperl#ifperl#pack()

" Commander: 
function! useperl#search#Commander(...) abort "{{{
    if a:0 == 0 || empty(a:1) || a:1 == '/'
        if has_key(b:, 'PerlSearch')
            let b:PerlSearch = {}
        endif
        return s:UnmapNext()
    endif

    let l:pattern = a:1
    if l:pattern =~ '^/'
        let l:pattern = l:pattern[1:]
    endif

    let l:pattern = s:QuoteSingle(l:pattern)
    let l:strOut = s:ifperl.call('SearchLine', l:pattern)
    if empty(l:strOut)
        return
    endif

    let l:lsOut = split(l:strOut, "\n")
    call s:InitResult(l:pattern, l:lsOut)
endfunction "}}}

" InitResult: 
function! s:InitResult(pattern, result) abort "{{{
    let b:PerlSearch = {}
    let b:PerlSearch.pattern = ''
    let b:PerlSearch.result = []
    let b:PerlSearch.pattern = a:pattern
    let b:PerlSearch.result = a:result

    call s:RemapNext()
    call s:next()
endfunction "}}}

" next: 
function! s:next() abort "{{{
    if !has_key(b:, 'PerlSearch') || empty(get(b:PerlSearch, 'result', []))
        return
    endif
    let l:curline = line('.')
    let l:length = len(b:PerlSearch.result)
    let l:idx = 0
    while l:idx < l:length
        let l:str = b:PerlSearch.result[l:idx]
        let l:linenr = 0 + matchstr(l:str, '^\d+')
        if l:linenr <= 0
            continue
        endif
        if l:linenr > l:curline
            execute l:linenr
            let l:match = matchstr(l:str, '^\d+:\s*\zs.*')
            let l:scmd = '/' . l:match . "\<CR>"
            execute 'normal!' l:scmd
            return
        endif
        let l:idx += 1
    endwhile
    echoerr 'search to the end, not find any more'
endfunction "}}}

" Next: 
function! s:Next() abort "{{{
    if !has_key(b:, 'PerlSearch') || empty(get(b:PerlSearch, 'result', []))
        return
    endif
    let l:curline = line('.')
    let l:length = len(b:PerlSearch.result)
    let l:idx = l:length - 1
    while l:idx >= 0
        let l:str = b:PerlSearch.result[l:idx]
        let l:linenr = 0 + matchstr(l:str, '^\d+')
        if l:linenr <= 0
            continue
        endif
        if l:linenr < l:curline
            execute l:linenr
            let l:match = matchstr(l:str, '^\d+:\s*\zs.*')
            let l:scmd = '/' . l:match . "\<CR>"
            execute 'normal!' l:scmd
            return
        endif
        let l:idx -= 1
    endwhile
    echoerr 'search to the end, not find any more'
endfunction "}}}

" RemapNext: 
function! s:RemapNext() abort "{{{
    nnoremap <buffer> n :call <SID>next()<CR>
    nnoremap <buffer> N :call <SID>Next()<CR>
    echomsg 'normal n has remaped to search perl regexp: ' . b:PerlSearch.pattern
endfunction "}}}

" UnmapNext: 
function! s:UnmapNext() abort "{{{
    nunmap <buffer> n
    nunmap <buffer> N
    echomsg 'normal n has restored to default'
endfunction "}}}

" QuoteSingle: 
let s:SINQUOTE = "'"
let s:DOUQUOTE = '"'
let s:BACKSLASH = '\'
let s:ESC_SINQUOTE = s:SINQUOTE . s:SINQUOTE
let s:ESC_DOUQUOTE = s:BACKSLASH . s:DOUQUOTE
function! s:QuoteSingle(str) abort "{{{
    let l:str = substitute(a:str, s:SINQUOTE, s:ESC_SINQUOTE, 'g')
    return s:SINQUOTE . l:str . s:SINQUOTE
endfunction "}}}
