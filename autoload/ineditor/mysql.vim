" File: mysql
" Author: lymslive
" Description: for mysql $EDITOR
" Create: 2018-08-09
" Modify: 2018-08-09

if !exists('g:ineditor#mysql#keepin_window')
    let g:ineditor#mysql#keepin_window = 0
endif

" PreviewTable: 
function! ineditor#mysql#PreviewTable(...) abort "{{{
    let l:table = get(a:000, 0, '')
    if empty(l:table)
        let l:table = s:GuessTable()
        if empty(l:table)
            echo 'expact a table name'
            return
        endif
    endif

    let l:sql = printf('show full columns from %s;', l:table)
    let l:format = '-t'
    let l:cmd = printf("%s %s -e %s", s:BuildCmdline(), l:format, shellescape(l:sql))
    let l:out = systemlist(l:cmd)
    if empty(l:out)
        return
    endif

    let l:sql = printf('select count(*) from %s;', l:table)
    let l:format = ''
    let l:cmd = printf("%s %s -e %s", s:BuildCmdline(), l:format, shellescape(l:sql))
    let l:outCount = systemlist(l:cmd)
    " call extend(l:out, l:outCount)
    let l:strCount = join(l:outCount, "\t")
    call add(l:out, l:strCount)

    if winnr('$') < 2
        new
        call s:SetPreviewBuffer()
        call append(0, l:out)
        call cursor(4, 0) " put cursor in the first field
        if g:ineditor#mysql#keepin_window
            wincmd p
        else
            stopinsert
        endif
    else
        wincmd p
        let l:maxLine = line('$')
        echomsg 'last maxLine' l:maxLine
        call append('$', l:out)
        call cursor(l:maxLine + 4, 0)
        " normal! G
        if g:ineditor#mysql#keepin_window
            wincmd p
        else
            stopinsert
        endif
    endif
endfunction "}}}

" BuildCmdline: 
function! s:BuildCmdline() abort "{{{
    let l:cmd = 'mysql'
    if !empty($MYSQL_PROG)
        let l:cmd = $MYSQL_PROG
    endif

    if !empty($MYSQL_HOST)
        let l:cmd .= ' -h ' . $MYSQL_HOST
    endif
    if !empty($MYSQL_PORT)
        let l:cmd .= ' -P ' . $MYSQL_PORT
    endif
    if !empty($MYSQL_USER)
        let l:cmd .= ' -u ' . $MYSQL_USER
    endif
    if !empty($MYSQL_PASS)
        let l:cmd .= ' -p' . $MYSQL_PASS
    endif
    if !empty($MYSQL_FLAG)
        let l:cmd .= ' ' . $MYSQL_FLAG
    endif
    if !empty($MYSQL_DATABASE)
        let l:cmd .= ' ' . $MYSQL_DATABASE
    endif

    return l:cmd
endfunction "}}}

" GuessTable: 
function! s:GuessTable(...) abort "{{{
    let l:iLine = get(a:000, 0, line('.'))
    let l:sLine = getline(l:iLine)
    let l:table = matchstr(l:sLine, '\cfrom\s\+\zs\S\+\ze')
    if !empty(l:table)
        return l:table
    endif

    let l:table = expand('<cword>')
    return l:table
endfunction "}}}

" SetPreviewBuffer: 
function! s:SetPreviewBuffer() abort "{{{
    setlocal buftype=nofile
    nnoremap <buffer> q :q<CR>
    " back to previous window and insert
    nnoremap gi <C-W>pgi
    vnoremap J :call ineditor#mysql#JoinBufLine(',', 1)<CR>
endfunction "}}}

" JoinBufLine: 
" join from the first word of line in selected range
" @input a:separator, a short string join between. eg ','
" @input a:space, add another count space after each separator
" @ouput 
"    replace the range lines with the joined string, and
"    put the string in register"
function! ineditor#mysql#JoinBufLine(separator, space) abort range "{{{
    let l:sJoin = ''
    for l:iLine in range(a:firstline, a:lastline)
        let l:sLine = getline(l:iLine)
        let l:word = matchstr(l:sLine, '\zs\w\+\ze')
        if empty(l:sJoin)
            let l:sJoin = l:word
        else
            let l:sJoin .= a:separator
            if a:space
                let l:sJoin .= repeat(' ', a:space)
            endif
            let l:sJoin .= l:word
        endif
    endfor

    " return l:sJoin
    execute a:firstline ',' a:lastline 'delete'
    call append(a:firstline-1, l:sJoin)
    let @" = l:sJoin

endfunction "}}}

" join first word of lines, '!' keep another space
command! -nargs=+ -bang -range=% JoinBufLine 
            \ <line1>,<line2> call ineditor#mysql#JoinBufLine(<q-args>, <bang>0)
