" File: main
" Author: lymslive
" Description: $MYVIMRC: ln -s this file to ~/.vimrc
" Create: 2017-03-21
" Modify: 2017-03-21

" Vital Variable:
let $VIMHOME = $HOME . '/.vim'
if has('win32') || has ('win64')
    let $VIMHOME = $VIM . '/vimfiles'
endif
let $STARTHOME = $VIMHOME . '/start'
let $PACKHOME  = $VIMHOME . '/pack'

let g:START_NAME = v:progname
let g:RUN_NAME = []

" Command: source script relative current script file
command! -nargs=1 SOURCE execute 'source ' . expand('<sfile>:p:h') . '/' . <q-args>

" Search Vimrc:
" 1. {v:progname}; 2. self.vim; 3. default.vim
let s:lpVimrc = glob($STARTHOME . '/' . g:START_NAME . '*.vim', '', 1)
let s:pVimrc = get(s:lpVimrc, 0, '')
if !empty(s:pVimrc) && filereadable(s:pVimrc)
    execute 'source ' . s:pVimrc
elseif filereadable($STARTHOME . '/self.vim')
    let s:pVimrc = $STARTHOME . '/self.vim'
    execute 'source ' . s:pVimrc
elseif filereadable($STARTHOME . '/default.vim')
    let s:pVimrc = $STARTHOME . '/default.vim'
    execute 'source ' . s:pVimrc
else
    let s:pVimrc = ''
endif

"EOF vim:tw=78:sts=4:ft=vim:fdm=marker:
