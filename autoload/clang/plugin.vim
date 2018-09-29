" File: clang#plugin
" Author: lymslive
" Description: for c/cpp
" Create: 2018-05-05
" Modify: 2018-05-05

if !exists('$SPACEVIM')
    packadd clang_complete
endif

" Clang_complete: {{{1
set completeopt=noselect,menu
let g:clang_snippets=1
let g:clang_snippets_engine="ultisnips"
let g:clang_use_library=1
let g:clang_close_preview=1
let g:clang_complete_macros=1
let g:clang_user_options='-stdlib=libc++ -std=c++11 -ICPLUS_INCLUDE_PATH'

" 不冲突 C-] C-T 快捷键
let g:clang_jumpto_declaration_key = '<C-\><C-]>'
let g:clang_jumpto_declaration_in_preview_key = '<C-\><C-p>'
let g:clang_jumpto_back_key = '<C-\><C-T>'

" Cscope: {{{1
" see: cscope_maps.vim bt Jason Duell
if has("cscope")

    " use relative path of cscpo.out
    set cscoperelative

    " use :cstag instead of the defualt :tag
    set cscopetag

    " 0: search cscope database, then tas files
    " 1: search tas files, then cscope database
    set cscopetagorder=0

    " print message
    set cscopeverbose

    " use quickfix for some cs find command
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    " automatic load cscope.out
    if filereadable("cscope.out")
        cs add cscope.out  
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    else
        " search upward for project
        let s:rtp = class#less#rtp#export()
        let s:prj = s:rtp.FindPrject('.')
        if !empty(s:prj) && filereadable(s:rtp.AddPath(s:prj, 'cscope.out'))
            execute 'cs add ' . s:rtp.AddPath(s:prj, 'cscope.out')
        endif
        unlet s:rtp s:prj
    endif

    " common map manage cscope work
    nnoremap <C-\>a :cs add cscope.out<CR>
    nnoremap <C-\>r :!cscope -Rbq<CR>
    nnoremap <C-\>h :cs help<CR>
    nnoremap <C-\>\ :cs find f 

    " find things under cursor
    nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

    " horizontally split find
    nnoremap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nnoremap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nnoremap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " vertical split find
    nnoremap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nnoremap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nnoremap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

" load: 
function! clang#plugin#load() abort "{{{1
    return 1
endfunction "}}}
