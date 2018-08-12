" File: vim.vim
" Author: lymslive
" Description: server as vimrc for mysql $EDITOR
" Create: 2017-03-25
" Modify: 2017-08-15

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

" 载入字典补全
if !empty($MYSQL_DBDICT)
    set dict+=$MYSQL_DBDICT
endif

filetype plugin indent on

" 临时文件设为 sql ，定位到末尾
augroup VISQL
    autocmd!
    autocmd! BufRead *sql* set filetype=sql | normal! G$
augroup END

" 直接进入编辑模式
startinsert

" :x
" 快速保存退出
inoremap <C-L> <Esc>:xall<CR>
nnoremap <C-L> <Esc>:xall<CR>
" 手动字典补全
inoremap <C-p> <C-X><C-K>
" 预览表定义，命令行参数各部分通过 $MYSQL_ 系列环境变量传入
command -nargs=? PreviewTable call ineditor#mysql#PreviewTable(<f-args>)
inoremap <C-]> <C-o>:PreviewTable<CR>
nnoremap <C-]> <Esc>:PreviewTable<CR>
" 预览表定义快捷键后，是否停留在原编辑窗口
let g:ineditor#mysql#keepin_window = 0
