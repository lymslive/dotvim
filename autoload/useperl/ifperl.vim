" File: ifperl
" Author: lymslive
" Description: tools for if_perl
" Create: 2018-08-12
" Modify: 2018-08-12


" UseLib: 
function! useperl#ifperl#UseLib(path) abort "{{{
    if !empty(a:path) && isdirectory(a:path)
        let l:perl = printf('perl use lib("%s");', a:path)
        execute l:perl
    endif
endfunction "}}}

" Require: 
function! useperl#ifperl#Require(file) abort "{{{
    if !empty(a:file)
        let l:perl = printf('perl require("%s");', a:file)
        execute l:perl
    endif
endfunction "}}}

" Module: 
function! useperl#ifperl#Module(pm) abort "{{{
    if !empty(a:pm)
        let l:perl = printf('perl use %s;', a:pm)
        execute l:perl
    endif
endfunction "}}}
