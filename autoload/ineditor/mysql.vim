" File: mysql
" Author: lymslive
" Description: for mysql $EDITOR
" Create: 2018-08-09
" Modify: 2018-08-09

if !exists('g:ineditor#mysql#keepin_window')
    let g:ineditor#mysql#keepin_window = 0
endif
if !exists('g:ineditor#mysql#history_file')
    let g:ineditor#mysql#history_file = $HOME . '/.mysql_history'
endif
if !exists('g:ineditor#mysql#start_with_history')
    let g:ineditor#mysql#start_with_history = 0
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
        new Result
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
        let l:bnrView = bufnr('Result', 0)
        if l:bnrView == -1
            edit Result
            call s:SetPreviewBuffer()
        elseif l:bnrView != bufnr('')
            execute 'buffer' l:bnrView
        endif
        let l:maxLine = line('$')
        echomsg 'last maxLine' l:maxLine
        call append('$', l:out)
        call cursor(l:maxLine + 4, 0)
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
    setlocal bufhidden=hide
    nnoremap <buffer> q :q<CR>
    " back to previous window and insert
    nnoremap <buffer> gi <C-W>pgi
    vnoremap <buffer> J :call ineditor#mysql#JoinBufLine(',', 1)<CR>
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

" LoadHistory: open history file
function! ineditor#mysql#LoadHistory() abort "{{{
    if g:ineditor#mysql#start_with_history < 1
        return
    endif
    if !filereadable(g:ineditor#mysql#history_file)
        return
    endif

    let l:history = readfile(g:ineditor#mysql#history_file)
    call filter(l:history, 'v:val !~? "^\\" && v:val !~? "^[ ;]*$"')

    silent new History
    call setline(1, l:history)
    normal! G$
    call s:OnHistory()

    " back to edit starting tmp file
    if g:ineditor#mysql#start_with_history < 2
        wincmd p
    endif

    let s:History = l:history
endfunction "}}}

" OnHistory: local maps in history window
function! s:OnHistory() abort "{{{
    setlocal filetype=sql
    setlocal buftype=nofile
    setlocal bufhidden=hide
    nnoremap <buffer> <C-L> <Esc>:ExecuteHistory<CR>
    inoremap <buffer> <C-L> <Esc>:ExecuteHistory<CR>
    vnoremap <buffer> <C-L> :ExecuteHistory<CR>
endfunction "}}}

" ExecuteHistory: 
" copy the sql from history window to tmp file 
" and back to mysql shell to execute
function! s:ExecuteHistory() abort range "{{{
    if empty(g:SQL_TMP_FILE)
        return
    endif
    let l:lsContent = getline(a:firstline, a:lastline)
    execute 'buffer' g:SQL_TMP_FILE
    : 1,$ delete
    call setline(1, l:lsContent)
    " trim space and \G
    : %s/^\s*\|\(\s*\\G\)\?\s*$//g
    : xall
endfunction "}}}
command! -range ExecuteHistory <line1>,<line2> call s:ExecuteHistory()

" AddHistory: 
function! ineditor#mysql#AddHistory() abort "{{{
    if empty(g:SQL_TMP_FILE)
        return
    endif
    let l:lastSql = s:History[-1]
    let l:lsContent = getbufline(bufnr(g:SQL_TMP_FILE), 1, "$")
    let l:currSql = join(l:lsContent, ' ')
    if l:currSql !=? l:lastSql
        call writefile([l:currSql], g:ineditor#mysql#history_file, 'a')
    endif
endfunction "}}}
