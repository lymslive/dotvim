" File: visql.vim
" Author: lymslive
" Description: server as vimrc for mysql $EDITOR
" Create: 2017-03-25
" Modify: 2018-08-24

" Common Vimrc:
" set nocompatible
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim

packadd vimproc.vim
packadd unite.vim
packadd ultisnips
packadd vim-snippets

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#enable_ignore_case = 1

if !exists('g:neocomplete#sources#omni#functions')
    let g:neocomplete#sources#omni#functions = {}
endif
let g:neocomplete#sources#omni#functions.sql = 'sqlcomplete#Complete'

let g:neocomplete#text_mode_filetypes = 
            \ {'text':1, 'markdown':1, 'tex':1, 'help':1} 
let g:neocomplete#sources#dictionary#dictionaries = 
            \ {'default':'', 'text':'~/.vim/dict/english.dic'}
packadd neocomplete.vim

if 1 " dbext
    packadd dbext
    let g:dbext_default_profile_mysql_visql = 'type=MYSQL:user=' . $MYSQL_USER . 
                \ ':passwd=' . $MYSQL_PASS .
                \ ':dbname=' . $MYSQL_DATABASE . 
                \ ':host=' . $MYSQL_HOST . 
                \ ':extra=' . $MYSQL_FLAG
    let g:dbext_default_profile = 'mysql_visql'
endif

" dictionary completiton
if !empty($MYSQL_DBDICT)
    set dict+=$MYSQL_DBDICT
endif

filetype plugin indent on

" quick quit, back to mysql shell
inoremap <C-L> <Esc>:xall<CR>
nnoremap <C-L> <Esc>:xall<CR>

nnoremap <Tab> <C-W>w
inoremap <C-n> <Down>
inoremap <C-p> <Up>

" PreviewTable:
command -nargs=? PreviewTable call ineditor#mysql#PreviewTable(<f-args>)
inoremap <C-]> <C-o>:PreviewTable<CR>
nnoremap <C-]> <Esc>:PreviewTable<CR>
let g:ineditor#mysql#keepin_window = 0

let g:ineditor#mysql#start_with_history = 2

" the starting edit file, usually a tmp sql file
if argc() > 0
    let g:SQL_TMP_FILE = argv(0)
else
    let g:SQL_TMP_FILE = ''
endif

" go to the end of tmp sql file
augroup VISQL
    autocmd!
    autocmd BufRead  *sql* setlocal filetype=sql | normal! G$
    autocmd VimEnter *     call ineditor#mysql#LoadHistory()
    autocmd VimLeave *     call ineditor#mysql#AddHistory()
augroup END

" finally enter to insert mode
startinsert

