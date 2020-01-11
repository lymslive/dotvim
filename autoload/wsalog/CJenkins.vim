" File: CJenkins
" Author: lymslive
" Description: a class represent a jenkins job
" Create: 2020-01-03
" Modify: 2020-01-07

let s:class = {}

let s:class.netURL = ''
let s:class.host = ''
let s:class.path = ''
let s:class.short = ''
let s:class.jobname = ''
let s:class.jobnumber = 0
let s:class.localBase = ''
let s:class.localLog = ''

" let s:localDefault = expand('~/log')
let s:localDefault = 'C:\Users\tans2\home\jklogs'

" current both are http://
let s:dHostMap = {
            \ 'sf1-lgsavci101' : 'sf1-lgsavci101.analytics.moodys.net:8080',
            \ 'jenkins-css' : 'jenkins-css'
            \ }

" Func: #class 
function! wsalog#CJenkins#class() abort
    return s:class
endfunction

" Func: #new 
function! wsalog#CJenkins#new(url, localBase) abort
    let l:obj = copy(s:class)
    let l:obj.netURL = a:url
    if empty(a:localBase)
        let l:obj.localBase = s:localDefault
    else
        let l:obj.localBase = a:localBase
    endif
    if l:obj.parse_url(a:url)
        return l:obj
    else
        return v:null
    endif
endfunction

" Func: #newFromBuffer 
function! wsalog#CJenkins#newFromBuffer() abort
    let l:obj = copy(s:class)
    if !empty(l:obj.init_from_buffer())
        return l:obj
    else
        return v:null
    endif
endfunction

" Method: parse_url 
" sample url, view part options, job/ matters
" http://sf1-lgsavci101:8080/view/WSA%20API/view/UDEV/job/WSA%20API%20-%20Linux%20-%20UDEV%20-%20Unit%20Tests%20(64-bit)/10895/consoleText
" return 1 if success, 0 if error
function! s:class.parse_url(url) dict abort
    let l:pattern = 'https\?://\(\S\{-\}\)/.\{-\}/\?job/\(.*\)$'
    let l:matches = matchlist(a:url, l:pattern)
    if empty(l:matches)
        return
    endif

    let l:host = l:matches[1]
    let l:path = l:matches[2]
    let l:short = matchstr(l:host, '^[^:.]\+\ze')
    if empty(l:short)
        let l:short = l:host
    endif

    let l:tokens = split(l:path, '/')
    if len(l:tokens) < 2
        return
    endif

    " job number is the last or last two part
    let l:last = l:tokens[-1]
    if l:last !~# '^\d\+$'
        call remove(l:tokens, -1)
        let l:last = l:tokens[-1]
    endif
    if l:last !~# '^\d\+$'
        return
    endif

    let l:jobnumber = l:last
    call remove(l:tokens, -1)
    let l:jobname = join(l:tokens, '/')

    let self.host = l:host
    let self.path = l:path
    let self.short = l:short
    let self.jobname = l:jobname
    let self.jobnumber = l:jobnumber
    return 1
endfunction

" Method: get_log_url 
function! s:class.get_log_url() dict abort
    let l:logurl = printf('http://%s/job/%s/%d/consoleText', self.host, self.jobname, self.jobnumber)
    return l:logurl
endfunction

" Method: get_local_log 
function! s:class.get_local_log() dict abort
    if !empty(self.localLog)
        return self.localLog
    endif
    let l:jobname = substitute(self.jobname, '%20', ' ', 'g')
    let l:log = printf('%s/%s/%s/%d.log', self.localBase, self.short, l:jobname, self.jobnumber)
    let l:dir = fnamemodify(l:log, ':h')
    if !isdirectory(l:dir)
        call mkdir(l:dir, 'p')
        if !isdirectory(l:dir)
            return
        endif
    endif
    let self.localLog = l:log
    return l:log
endfunction

" Method: log_download 
" a:1, force download, ingore local file
function! s:class.log_download(...) dict abort
    let l:local = self.get_local_log()
    if empty(l:local)
        return
    endif
    if a:0 == 0 || empty(a:1)
        if filereadable(l:local) && getfsize(l:local) > 0
            return self.open_local(l:local)
        endif
    endif
    let l:remote = self.get_log_url()
    let l:cmd = 'curl -s ' . l:remote
    let l:options= {}
    let l:options.out_io = 'file'
    let l:options.out_name = l:local
    let l:options.exit_cb = self.on_exit
    let self.vimjob = job_start(l:cmd, l:options)
    echomsg 'await$ l:cmd'
endfunction

" Method: on_exit 
function! s:class.on_exit(job, status) dict abort
    echomsg 'job exit with ' . a:status
    let l:local = self.get_local_log()
    let l:remote = self.get_log_url()
    if filereadable(l:local)
        echomsg 'success to download log: ' . l:local
        call self.open_local(l:local)
        return l:local
    else
        echomsg 'fail to download log: ' . l:retmote
        return ''
    endif
endfunction

" Method: open_local 
function! s:class.open_local(...) dict abort
    if a:0 == 0 || empty(a:1)
        let l:local = self.get_local_log()
    else
        let l:local = a:1
    endif
    silent execute 'edit ' . l:local
    call wsalog#buffer#init(self)
endfunction

" Method: init_from_buffer 
function! s:class.init_from_buffer() dict abort
    let l:filepath = expand('%:p')
    let l:filepath = substitute(l:filepath, '^.:', '\U&', '')
    let l:idx = stridx(l:filepath, s:localDefault)
    if l:idx != 0
        return v:null
    endif

    let l:relative = strpart(l:filepath, len(s:localDefault) + 1)
    let l:parts = split(l:relative, '\\')
    if len(l:parts) < 3
        return v:null
    endif

    let l:short = l:parts[0]
    let l:jobname = l:parts[1]
    let l:jobnumber = l:parts[-1]
    let l:jobnumber = matchstr(l:jobnumber, '^\d\+\ze')
    let l:jobname = join(l:parts[1:-2], '/')
    let l:jobname = substitute(l:jobname, ' ', '%20', 'g')

    let l:host = s:dHostMap[l:short]
    let l:path = printf('%s/%d/consoleText', self.jobname, self.jobnumber)

    let self.host = l:host
    let self.path = l:path
    let self.short = l:short
    let self.jobname = l:jobname
    let self.jobnumber = l:jobnumber
    let self.netURL = self.get_log_url()
    let self.localBase = s:localDefault
    let self.localLog = l:filepath
    return self
endfunction

" Method: switch_nubmer 
" clone a new object only replace number
function! s:class.switch_number(number) dict abort
    if a:number <= 0
        return v:null
    endif
    let l:obj = copy(self)
    let l:obj.jobnumber = a:number
    let l:obj.path = printf('%s/%d/consoleText', l:obj.jobname, l:obj.jobnumber)
    let l:obj.netURL = l:obj.get_log_url()
    let l:obj.localLog = ''
    let l:obj.localLog = l:obj.get_local_log()
    return l:obj
endfunction
