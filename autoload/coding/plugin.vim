" File: coding#plugin
" Author: lymslive
" Description: for common coding
" Create: 2018-05-05
" Modify: 2018-05-05
"

let s:thispath = expand('<sfile>:p:h')

" Auto Plugin:
PI edvsplit microcmd qcmotion
if !exists('$SPACEVIM')
    PI usetabpg wraptext
endif

set shiftwidth=4
set tabstop=4
set expandtab

" Complete Menu: {{{1
set complete -=i
inoremap <silent><expr> <C-e> pumvisible()? "\<C-e>" : "\<End>"
inoremap <silent><expr> <C-y> pumvisible()? "\<C-y>" : "\<C-R>\""
inoremap <silent><expr> <tab>
            \ pumvisible()? "\<c-n>" : "\<c-n>"
inoremap <silent><expr> <s-tab>
            \ pumvisible()? "\<c-p>" : "\<s-tab>"

" PackAdd Plugin: {{{1
if !exists('$SPACEVIM')
    silent! packadd nerdtree
    silent! packadd tagbar
    silent! packadd LeaderF

    silent! packadd ultisnips
    silent! packadd vim-snippets
    silent! packadd CompleteParameter.vim

    " silent packadd vimproc.vim
    " silent packadd unite.vim

    silent! packadd neocomplete.vim
    " packadd YouCompleteMe
    silent! packadd vim-auto-popmenu

    silent! packadd ack.vim
    " packadd vim-dict
    " packadd incsearch.vim

    silent! packadd asyncrun.vim
    silent! packadd vim-surround
    " packadd vim-signature
endif
" echomsg 'packadd end'

" NERDTree: {{{1
nnoremap ;f :NERDTreeToggle<CR>
nnoremap ;F :NERDTreeMirror<CR>
" 自动关闭
let NERDTreeQuitOnOpen=1
" 忽略文件，f 键切换是否隐藏
let NERDTreeIgnore = ['\~$', '\.swp', '\.svn', '\.git', '\.pyc', '\.o', '\.d', '\.gcno', '\.gcda']
let NERDTreeRespectWildIgnore = 1

" Tagbar: {{{1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap ;t :Tagbar<CR>

" GTags: {{{1
if executable('gtags') && executable('global')
    execute 'source ' . s:thispath . '/gtags.vim'
    execute 'source ' . s:thispath . '/gtags-cscope.vim'
    set cscopetag
    set cscopetagorder=0
    " use quickfix for some cs find command
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

if executable('ctags')
    nnoremap <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    command Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
endif

" Unite: {{{1
if exists(':Unite')
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap \u :Unite 

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

endif

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

" YouCompleteMe: {{{1
if 0
    let g:ycm_key_list_select_completion=[]
    let g:ycm_key_list_previous_completion=[]
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_min_num_of_chars_for_completion=3
    let g:ycm_seed_identifiers_with_syntax=1
endif

" Ultisnips: {{{1
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEnableSnipMate = 0
let g:snips_author = 'lymslive'

" Ack: {{{1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    cabbrev AG AsyncRun ag --vimgrep .<Left><Left>
endif

" Leaderf: {{{1
let g:Lf_WorkingDirectoryMode = 'Ac'
" \f \b has default
" noremap \f 
" noremap \b 
noremap \F :<C-U>Leaderf file .<CR>
noremap \t :<C-U>Leaderf bufTag<CR>
noremap \T :<C-U>Leaderf tag<CR>
noremap \a :<C-U>Leaderf self<CR>
noremap \m :<C-U>Leaderf mru<CR>
noremap \M :<C-U>LeaderfMruCwd <CR>
noremap \h :<C-U>Leaderf help<CR>
noremap \c :<C-U>Leaderf cmdHistory<CR>
noremap \s :<C-U>Leaderf searchHistory<CR>

" CompleteParameter: {{{1
let g:complete_parameter_use_ultisnips_mapping = 1

" ApcEnable: {{{1
" skywind3000/vim-auto-popmenu
let g:apc_enable_tab = 0

" LOAD:
function! coding#plugin#load(...) abort "{{{1
    return 1
endfunction "}}}
" echomsg 'coding/plugin.vim loaded'

