" File: useperl
" Author: lymslive
" Description: auto plugin for perl
" Create: 2018-05-16
" Modify: 2018-05-16

let s:thisdir = expand('<sfile>:h')

" Rerldoc:
" https://github.com/hotchpotch/perldoc-vim
execute 'source ' . s:thisdir . '/perldoc.vim'
nnoremap <silent> <Plug>(perldoc) :<C-u>Perldoc<CR>

if has('perl')
    call useperl#ifperl#load(s:thisdir)
endif

" load: 
function! useperl#plugin#load() abort "{{{
    return 1
endfunction "}}}
