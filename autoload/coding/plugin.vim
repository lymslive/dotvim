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

    silent! packadd vim-auto-popmenu
    silent! packadd coc.nvim

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

" Coc: {{{1
if exists(':CocEnable')
    inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)       " 跳转到定义处
    nmap <silent> gy <Plug>(coc-type-definition)  " 跳转到类型定义处
    nmap <silent> gm <Plug>(coc-implementation)   " 跳转到实现处
    nmap <silent> gr <Plug>(coc-references)       " 查找引用

    noremap gc :CocList<CR>
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

" ApcEnable: {{{1
" skywind3000/vim-auto-popmenu
let g:apc_enable_tab = 0

" LOAD:
function! coding#plugin#load(...) abort "{{{1
    return 1
endfunction "}}}
" echomsg 'coding/plugin.vim loaded'

