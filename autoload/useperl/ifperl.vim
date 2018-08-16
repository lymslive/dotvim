" File: ifperl
" Author: lymslive
" Description: tools for if_perl
" Create: 2018-08-12
" Modify: 2018-08-12

if !has('perl')
    echoerr 'you vim version seams donnt support perl!'
    finish
endif
let g:DEBUG = 1

" glob variable exchange with perl code
let g:useperl#ifperl#scalar = ''
let g:useperl#ifperl#list = []
let g:useperl#ifperl#dict = {}

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
command! -nargs=+ -complete=customlist,<SID>complist_pl PerlFile call <SID>require(<q-args>)

" Module: 
" :PerlUse module
" :PerlUse module qw(xxx yyy)
function! s:use(pm) abort "{{{
    if !empty(a:pm)
        let l:perl = printf('perl use %s;', a:pm)
        execute l:perl
    endif
endfunction "}}}
command! -nargs=+ -complete=customlist,<SID>complist_pm PerlUse call <SID>use(<q-args>)

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
    :DLOG 'debug: ' .  l:perl
    " let l:ifstdout = ''
    let v:errmsg = ''
    redir => l:ifstdout
    silent! execute l:perl
    redir END

    if v:errmsg
        return ''
    endif

    " redir will generate an extra \n before message?
    if l:ifstdout =~ "^\n"
        let l:ifstdout = substitute(l:ifstdout, "^\n", '', '')
    endif

    return l:ifstdout
endfunction "}}}
command! -nargs=+ -complete=customlist,<SID>complist_sym PerlCall echo <SID>call(<f-args>)
command! -nargs=+ -complete=customlist,<SID>complist_sym PerlPrint perl print <args>

" complete_pl: 
" find file in @INC path
function! s:complist_pl(ArgLead, CmdLine, CursorPos) abort "{{{
    let l:lsIncPath = s:call('GotIncPath')
    let l:pattern = a:ArgLead . '**'
    let l:lsGlob = globpath(l:lsIncPath, l:pattern, 0, 1)
    call map(l:lsGlob, {key, val -> substitute(val, '^.*\ze' . a:ArgLead, '', 'g')})
    return l:lsGlob
endfunction "}}}

" complete_pm: 
" find module in @INC path
function! s:complist_pm(ArgLead, CmdLine, CursorPos) abort "{{{
    let l:ArgLead = substitute(a:ArgLead, '::', '/', 'g')
    let l:lsGlob = s:complete_pl(l:ArgLead, a:CmdLine, a:CursorPos)
    call filter(l:lsGlob, 'v:val =~? "\.pm$"')
    call map(l:lsGlob, {key, val -> substitute(val, '/', '::', 'g')})
    call map(l:lsGlob, {key, val -> substitute(val, '\.pm$', '', 'g')})
    return l:lsGlob
endfunction "}}}

" complete_sym: 
" :PerlPrint SearchLine
" :PerlPrint $InsideVim
" :PerlPrint $main::InsideVim
function! s:complist_sym(ArgLead, CmdLine, CursorPos) abort "{{{
    let l:module = matchstr(a:ArgLead, '^[%&$@]\?\zs.*\ze::')
    let l:module_save = l:module
    if empty(l:module)
        let l:module = 'main'
    endif
    let l:sign = matchstr(a:ArgLead, '^[%&$@]\ze')
    let l:lead = matchstr(a:ArgLead, '[^%&$@:]*$')

    " return s:call('GotModuleSyms', l:module)

    " GotModuleSyms return symbols without sign $@%
    let l:str = s:call('GotModuleSyms', l:module)
    let l:list = split(l:str, "\n")
    if !empty(l:lead)
        call filter(l:list, 'v:val =~# "^" . l:lead')
    endif

    let l:prefix = l:sign
    if !empty(l:module_save)
        let l:prefix .= l:module . '::'
    endif
    if !empty(l:prefix)
        call map(l:list, 'l:prefix . v:val')
    endif
    return l:list
endfunction "}}}

" pack: 
function! useperl#ifperl#pack() abort "{{{
    if !exists('s:pack')
        let s:pack = {}
        let s:pack.call = function('s:call')
    endif
    return s:pack
endfunction "}}}

" load: 
" a:1, add the source directory to @INC of perl
function! useperl#ifperl#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1)
        call s:uselib(a:1)
    endif
    PerlFile ifperl.pl
endfunction "}}}

finish
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" test regexp
SearchLine
$InsideVim
$main::InsideVim
%VIM::
