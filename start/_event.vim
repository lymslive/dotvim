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
                \if !isdirectory(expand("%:p:h")) |
                \  call mkdir(expand("%:p:h"), "p") |
                \endif

    " When open terminal
    if exists('##TerminalOpen')
        autocmd! TerminalOpen * PI useterm
    endif

    if exists('##GUIEnter')
        autocmd! GUIEnter * simalt ~x
    endif
augroup END

