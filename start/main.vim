" File: main
" Author: lymslive
" Description: $MYVIMRC: ln -s this file to ~/.vimrc
" Create: 2017-03-21
" Modify: 2017-03-24

" Vital Variable: {{{1
let $VIMHOME = $HOME . '/.vim'
if has('win32') || has ('win64')
    let $VIMHOME = $VIM . '/vimfiles'
endif
let $STARTHOME = $VIMHOME . '/start'
let $PACKHOME  = $VIMHOME . '/pack'

let g:START_NAME = v:progname
let g:START_VIMRC = ''
let g:RUN_NAME = []

" Custom Config: {{{1
let s:dStartAlias = {}
let s:dStartAlias.view = 'vi'

" Vimrc Tools: {{{1
" Command: source script relative current script file
command! -nargs=1 SOURCE execute 'source ' . expand('<sfile>:p:h') . '/' . <q-args>

" LoadVimrc: return true if load vimrc success
function! s:LoadVimrc(pVimrc) abort "{{{
    if !empty(a:pVimrc) && filereadable(a:pVimrc)
        execute 'source ' . a:pVimrc
        let g:START_VIMRC = a:pVimrc
        call add(g:RUN_NAME, fnamemodify(a:pVimrc, ':p:t:r'))
        return 1
    else
        return 0
    endif
endfunction "}}}

" Search Vimrc: {{{1
if v:progname =~? '^vim-.\+'
    let g:START_NAME = substitute(v:progname, '^vim-', '', '')
endif

if has_key(s:dStartAlias, g:START_NAME)
    let g:START_NAME = s:dStartAlias[g:START_NAME]
endif

" 1. self_{g:START_NAME}*.vim
let s:lpVimrc = glob($STARTHOME . '/self_' . g:START_NAME . '*.vim', '', 1)
let s:pVimrc = get(s:lpVimrc, 0, '')
if s:LoadVimrc(s:pVimrc)
    finish
endif

" 2. {g:START_NAME}*.vim
let s:lpVimrc = glob($STARTHOME . '/' . g:START_NAME . '*.vim', '', 1)
let s:pVimrc = get(s:lpVimrc, 0, '')
if s:LoadVimrc(s:pVimrc)
    finish
endif

" 3. default_{g:START_NAME}*.vim
let s:lpVimrc = glob($STARTHOME . '/default_' . g:START_NAME . '*.vim', '', 1)
let s:pVimrc = get(s:lpVimrc, 0, '')
if s:LoadVimrc(s:pVimrc)
    finish
endif

" 4. self.vim
let s:pVimrc = $STARTHOME . '/self.vim'
if s:LoadVimrc(s:pVimrc)
    finish
endif

" 5. self.vim
let s:pVimrc = $STARTHOME . '/default.vim'
if s:LoadVimrc(s:pVimrc)
    finish
endif

" Footer Vimrc: {{{1
call add(g:RUN_NAME, 'main')

set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
set noloadplugins
set nocompatible
set incsearch
set hlsearch
set showcmd
set ruler
colorschem desert
syntax on

" resemble fast viewer, further vimrc will override them.
nnoremap w :update<cr>w
nnoremap q :quit<cr>
nnoremap z <C-Z>
nnoremap <CR> :

" transfer to minied rc
autocmd! InsertEnter * mapclear | source $STARTHOME/minied.vim | autocmd! InsertEnter
" transfer to fulled rc
nnoremap <Tab> :mapclear<CR>:source $STARTHOME/fulled.vim<CR>

"EOF vim:tw=78:sts=4:ft=vim:fdm=marker:
