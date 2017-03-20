" $MYVIMRC: ln -s this file to ~/.vimrc
" Maintainer: lymslive
" Modify: 2016-01-28

" Figure out the $VIMHOME path
if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" vcide:
if v:progname == "vc" || v:progname == "vcide"
    source $VIMHOME/start/vcide.vim
    finish
endif

" gvim / vim : load full version of vimrc.
if v:progname == "gvim" || v:progname == "vim" " {{{
    source $VIMHOME/start/fulled.vim
    finish
endif " }}}

" common vi:
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
set noloadplugins
set nocompatible
set incsearch
set hlsearch
set showcmd
set ruler
" colorschem molokai
syntax on

" resemble fast viewer, further vimrc will override them.
nnoremap w :update<cr>w
nnoremap q :quit<cr>
nnoremap z <C-Z>
nnoremap <CR> :

" the rest is for default vi. 
nnoremap <Tab> :mapclear<CR>:source $VIMHOME/start/fulled.vim<CR>
autocmd! InsertEnter * source $VIMHOME/start/minied.vim | autocmd! InsertEnter | mapclear

"EOF vim:tw=78:sts=4:ft=vim:fdm=marker:
