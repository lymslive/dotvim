" File: ifperl
" Author: lymslive
" Description: tools for if_perl
" Create: 2018-08-12
" Modify: 2018-08-12

if !has('perl')
    echoerr 'you vim version seams donnt support perl!'
endif

" UseLib: 
" :PerlLib path-to-add-INC
function! s:uselib(path) abort "{{{
    if !empty(a:path) && isdirectory(a:path)
        let l:perl = printf('perl use lib("%s");', a:path)
        execute l:perl
    endif
endfunction "}}}
command! -nargs=+ -complete=dir PerlLib call <SID>uselib(<q-args>)

" Require: 
" :PerlFile filename.pl
function! s:require(file) abort "{{{
    if !empty(a:file)
        let l:perl = printf('perl require("%s");', a:file)
        execute l:perl
    endif
endfunction "}}}
command! -nargs=+ PerlFile call <SID>require(<q-args>)

" Module: 
" :PerlUse module
" :PerlUse module qw(xxx yyy)
function! s:use(pm) abort "{{{
    if !empty(a:pm)
        let l:perl = printf('perl use %s;', a:pm)
        execute l:perl
    endif
endfunction "}}}
command! -nargs=+ PerlUse call <SID>use(<q-args>)

" call: 
" call a perl function, return the output as string
function! s:call(func, ...) abort "{{{
    if empty(a:func)
        return ''
    endif

    let l:args = ''
    if a:0 == 1
        let l:args = a:1
    elseif a:0 > 1
        let l:args = join(a:000, ',')
    endif

    let l:perl = printf('perl %s(%s);', a:func, l:args)
    let l:perlstdout = ''
    let v:errmsg = ''
    redir => l:perlstdout
    execute l:perl
    redir => END

    if v:errmsg
        return ''
    endif

    return l:perlstdout
endfunction "}}}
command! -nargs=+ PerlCall <SID>call(<f-args>)

" complete_pl: 
function! s:complete_pl(ArgLead, CmdLine, CursorPos) abort "{{{
    " code
endfunction "}}}

" complete_pl: 
function! s:complete_pm(ArgLead, CmdLine, CursorPos) abort "{{{
    " code
endfunction "}}}

" load: 
" a:1, add the source directory to @INC of perl
function! useperl#ifperl#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1)
        call s:uselib(a:1)
    endif
    PerlFile ifperl.pl
endfunction "}}}
