" File: coding#plugin
" Author: lymslive
" Description: for common coding
" Create: 2018-05-05
" Modify: 2018-05-05
"

" Auto Plugin:
PI edvsplit microcmd qcmotion
if !exists('$SPACEVIM')
    PI usetabpg wraptext
endif

" PackAdd Plugin: {{{1
if !exists('$SPACEVIM')
    packadd nerdtree
    packadd tagbar

    packadd ultisnips
    packadd vim-snippets

    packadd vimproc.vim
    packadd unite.vim
    " packadd neoyank.vim
    " packadd neomru.vim
    " packadd unite-outline
    " packadd unite-help
    " packadd neoinclude.vim
    " packadd unite-tag
    " packadd vim-unite-cscope

    packadd neocomplete.vim
    " packadd YouCompleteMe

    packadd ack.vim
    " packadd vim-dict
    " packadd incsearch.vim

    packadd vim-surround
    " packadd vim-signature
endif

" NERDTree: {{{1
nnoremap ;f :NERDTreeToggle<CR>
nnoremap ;F :NERDTreeMirror<CR>
" 自动关闭
let NERDTreeQuitOnOpen=1
" 忽略文件
let NERDTreeIgnore = ['\~$', '\.swp', '\.svn', '\.git', '\.pyc', '\.o', '\.d']
let NERDTreeRespectWildIgnore = 1

" Tagbar: {{{1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap ;t :Tagbar<CR>
nnoremap <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Unite: {{{1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap \u :Unite 
nnoremap <C-p><CR> :Unite<CR>
nnoremap <C-p><Space> :Unite 
nnoremap <C-n> :<C-u>UniteResume<CR>
nnoremap <C-p>f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <C-p>b :<C-u>Unite -buffer-name=buffer buffer bookmark<CR>
nnoremap <C-p>m :<C-u>Unite -buffer-name=mur file_mru<CR>
nnoremap <C-p>t :<C-u>Unite -buffer-name=tag tag<CR>
nnoremap <C-p>o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <C-p>r :<C-u>Unite register<CR>
nnoremap <C-p>y :<C-u>Unite -buffer-name=yank history/yank<CR>
nnoremap <C-p>j :<C-u>Unite jump<CR>
nnoremap <C-p>p :<C-u>Unite -start-insert -buffer-name=project file_list:!/cscope.files<CR>

" unite grep source
if executable('ag')
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
    " Use ack
    " http://beyondgrep.com/
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts =
                \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
endif

" grep by prompt
nnoremap <C-p>g :<C-u>Unite -buffer-name=grep grep<CR>
" grep current word in current dir
nnoremap <C-p><C-g> :<C-u>Unite -buffer-name=grep -input=<C-R><C-W> grep:.<CR>

" Neocomplete: {{{1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#ignore_source_files = ['tag.vim']
let g:neocomplete#enable_ignore_case = 1
" let g:neocomplete#enable_smart_case = 1
let g:neocomplete#text_mode_filetypes = 
            \ {'text':1, 'markdown':1, 'tex':1, 'help':1} 
let g:neocomplete#sources#dictionary#dictionaries = 
            \ {'default':'', 'text':'~/.vim/dict/english.dic'}
command! NE NeoCompleteEnable

" Neosnippet: {{{1
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/bundle/neosnippet-snippets/neosnippets'

" Signature: {{{1
" nnoremap \m :SignatureToggleSigns<CR>

" YouCompleteMe: {{{1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=3
let g:ycm_seed_identifiers_with_syntax=1

" Ultisnips: {{{1
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEnableSnipMate = 0
let g:snips_author = 'lymslive'

" Incsearch Map: {{{1
" 增量搜索优化，没感觉到差异？
" nmap /  <Plug>(incsearch-forward)
" nmap ?  <Plug>(incsearch-backward)
" nmap g/ <Plug>(incsearch-stay)

" Ack: {{{1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" LOAD:
function! coding#plugin#load(...) abort "{{{1
    return 1
endfunction "}}}

