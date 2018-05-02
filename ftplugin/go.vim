" Vim filetype plugin
" Language:	go
" Maintainer: lymslive
" Modify: 2018-05-01

" Plugin:
if !exists('s:once')
    let s:once = 1
    packadd vim-go
    let g:go_doc_url='https://golang.google.cn'
    let g:go_fmt_command = "goimports"
endif

" Indent:
setlocal tabstop=4
setlocal shiftwidth=4

setlocal formatoptions+=ro
set foldmethod=syntax
set foldlevelstart=99

" Comment:
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>

" Maps: 
" for vim-go
nnoremap <buffer> <F12> <Esc>:GoDocBrowser<CR>
nnoremap <buffer> <F9> <Esc>:GoBuild<CR>
nnoremap <buffer> <F10> <Esc>:GoTest<CR>
nnoremap <buffer> <F5> <Esc>:GoRun<CR>
nnoremap <buffer> <F6> <Esc>:GoInstall<CR>
nnoremap <buffer> <F2> <Esc>:GoRename<CR>

command! -buffer A :GoAlternate
