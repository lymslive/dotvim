" my markdown ftplugin
" lymslive / 2016-08-31

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

" 注释块
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('<!-- ', ' -->', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('<!-- ', ' -->', "v")<CR>

" Map Set: "{{{1
nnoremap <buffer> [[ :call search('^\s*#\+', 'Wb')<CR>
nnoremap <buffer> ]] :call search('^\s*#\+', 'W')<CR>
nnoremap <buffer> [= :call <SID>SearchHeader(0, 'Wb')<CR>
nnoremap <buffer> ]= :call <SID>SearchHeader(0, 'W')<CR>
nnoremap <buffer> [- :call <SID>SearchHeader(-1, 'Wb')<CR>
nnoremap <buffer> ]- :call <SID>SearchHeader(-1, 'W')<CR>

iabbrev #h <C-R>=<SID>InsertHeader(0)<CR>
iabbrev #k <C-R>=<SID>InsertHeader(-1)<CR>
iabbrev #j <C-R>=<SID>InsertHeader(1)<CR>

" Function Defind:  "{{{1
" get the last head level, number of '#'s
" a:start, start line number, if <= 0, relative cunnrent line
function! s:GetHeadLevel(start) "{{{
    if a:start > 0
        let l:start = a:start
    else
        let l:start = line('.') + a:start
    endif

    let l:head = ''
    let l:line = l:start
    while l:line >= 1
        let l:linestr = getline(l:line)
        let l:list = matchlist(l:linestr, '\s*\(#\+\)')
        if len(l:list) > 0
            let l:head = l:list[1]
            break
        endif
        let l:line -= 1
    endwhile

    return len(l:head)
endfunction "}}}

" insert header string, repeated '#' chars
" a:shift is relative the currnet header level
function! s:InsertHeader(shift) "{{{
    let l:level = s:GetHeadLevel(-1)
    let l:level += a:shift
    if l:level <= 0
        return '#'
    else
        return repeat('#', l:level)
    endif
endfunction "}}}

" search a header line
function! s:SearchHeader(shift, flag) "{{{
    let l:level = s:GetHeadLevel(0)
    let l:level += a:shift
    if l:level <= 0
        let l:level = 1
    endif

    let l:head = repeat('#', l:level)
    let l:pattern = '^\s*' . l:head . '[^#]'
    call search(l:pattern, a:flag)
endfunction "}}}
