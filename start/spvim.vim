" File: vim.vim
" Author: lymslive
" Description: my addtion config for SpaceVim
" Create: 2018-06-27
" Modify: 2018-06-27

" Before SpaceVim:
packadd StartVim
packadd vimloo
packadd autoplug
call autoplug#load()
source $STARTHOME/_remap.vim

let g:dein#types#git#default_protocol = 'ssh'

" Load SpaceVim:
let $SPACEVIM = $HOME . '/SpaceVim'
execute 'source ' . $SPACEVIM . '/init.vim'

" After SpaceVim:
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autowriteall
set nonumber
set norelativenumber
set autochdir
inoremap <C-e> <C-o>A
inoremap <C-y> <C-R>"

" Plugin Tagbar:
nnoremap ;t :Tagbar<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let NERDTreeQuitOnOpen=1
nnoremap ;f :NERDTreeMirror<CR>
" nnoremap ;f :VimFiler -force-hide<CR>
