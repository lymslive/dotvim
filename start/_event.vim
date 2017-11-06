" auto event command
augroup vimrcEx
    autocmd!
    " Restore the last positon when close
    autocmd! BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   execute "normal! g`\"" |
            \ endif

    " When write files to noexists path, make the necessary directory.
    autocmd! BufWritePre *
            \ if !isdirectory(expand("%:p:h")) |
            \  call mkdir(expand("%:p:h"), "p") |
            \ endif

    " auto highlight current column
    hi CursorColumn ctermbg=240
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
augroup END

" When Entering the Command window, redefine the <Enter> keyboard locally
augroup CmdWindow
    autocmd!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

