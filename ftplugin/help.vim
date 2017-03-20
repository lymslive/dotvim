" Vim filetype plugin file
" Language:         Vim help file
" Maintainer:       lymslive
" Latest Revision:  2011-10-20
" global ftp-file:  /usr/share/vim/vim72/ftplugin/help.vim

" since help file is read-only, remap the edit-key for navigation

setlocal dictionary=~/.vim/dict/english.dic

" follow links and return
nnoremap <buffer> i <C-]>
nnoremap <buffer> a <C-T>

" find the next(previous) option(subject) link
nnoremap <buffer> o /''[a-z]\{2,\}''<CR>
nnoremap <buffer> O ?''[a-z]\{2,\}''<CR>
nnoremap <buffer> s /\|\S\+\|<CR>
nnoremap <buffer> S ?\|\S\+\|<CR>

nnoremap <buffer> q :q<CR>
nnoremap <buffer> <C-CR> :help 

nnoremap <buffer> d <C-D>
nnoremap <buffer> u <C-U>
