" File: useperl
" Author: lymslive
" Description: auto plugin for perl
" Create: 2018-05-16
" Modify: 2018-05-16

let s:thisdir = expand('<sfile>:h')

" Perldoc:
" based on: https://github.com/hotchpotch/perldoc-vim
execute 'source ' . s:thisdir . '/perldoc.vim'
nnoremap <silent> <Plug>(perldoc) :<C-u>Perldoc<CR>

" Perlomni:
" based on: https://github.com/c9s/perlomni.vim
execute 'source ' . s:thisdir . '/perlomni.vim'

if !exists(':DLOG')
    command -nargs=* DLOG "pass
endif

if has('perl')
    call useperl#ifperl#load(s:thisdir)

    " command abbreviation
    cabbrev PP PerlPrint
    cabbrev PS PerlSearch

    command! -nargs=* PerlSearch call useperl#search#Commander(<q-args>)
endif

" load: 
function! useperl#plugin#load() abort "{{{
    return 1
endfunction "}}}

" dir: 
function! useperl#plugin#dir() abort "{{{
    return s:thisdir
endfunction "}}}
