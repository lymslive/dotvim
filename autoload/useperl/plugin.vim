" File: useperl
" Author: lymslive
" Description: auto plugin for perl
" Create: 2018-05-16
" Modify: 2018-05-16

let s:thispath = fnamemodify(expand("<sfile>"), ":p:h")

" Rerldoc:
" https://github.com/hotchpotch/perldoc-vim
execute 'source ' . s:thispath . '/perldoc.vim'
nnoremap <silent> <Plug>(perldoc) :<C-u>Perldoc<CR>

" load: 
function! useperl#plugin#load() abort "{{{
    return 1
endfunction "}}}
