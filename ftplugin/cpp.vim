" Vim filetype plugin file of mine
" Language:	C++
" Maintainer:	lymslive
" Last Changed: 2016-01-08

PI clang

set foldmethod=syntax
set foldlevelstart=99

" 注释
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>
vnoremap <buffer> ,X <ESC>:call wraptext#func#wrap('#if 0', '#endif', visualmode())<CR>

" 空格快捷键模式
silent! call Spacebar#SpaceModeSelect('Cpp')

" Compile:
" compile current file
setlocal makeprg=g++\ -std=c++0x\ -c\ %
nnoremap <buffer> <F9> :make<CR>
" build, remain in cmdline, may input other file
nnoremap <buffer> <C-F9> :!g++ -o %< %
" run
nnoremap <buffer> <F5> :!./%< <CR>

if exists('g:clang_complete_loaded')
	nnoremap <F8> :update<CR>:call g:ClangUpdateQuickFix()<CR>:botright cwindow<CR>
endif

" Insert Mode:

" contronl statement
iabbrev <buffer> b; break;
iabbrev <buffer> c; continue;
iabbrev <buffer> r; return 0;

" macro definition
iabbrev <buffer> #i #include
iabbrev <buffer> #d #define
iabbrev <buffer> #f #ifdef<CR>#endif<Esc>ka
iabbrev <buffer> #n #ifndef<CR>#endif<Esc>ka
iabbrev <buffer> #h #ifndef <C-R>=toupper(expand("%<")."_H__")<CR><CR>#define <C-R>=toupper(expand("%<")."_H__")<CR><CR>#endif<ESC>O

" labels 
iabbrev <buffer> a: private:
iabbrev <buffer> b: public:
iabbrev <buffer> c: protected:
iabbrev <buffer> d: default:
iabbrev <buffer> e: case:

" declaretion options
iabbrev <buffer> -e explicit
iabbrev <buffer> -f friend
iabbrev <buffer> -i inline
iabbrev <buffer> -s static
iabbrev <buffer> -c const
iabbrev <buffer> -t template <class T>

" in case class name is file name
" type C:: to get <class>:: wher class is the filename
iabbrev <buffer> C: <C-R>=expand("%<")<CR>:
" get ~<filename> as decontructor
iabbrev <buffer> ~C <C-R>="~".expand("%<")<CR>()
" type "h" to get "<filename>.h"
iabbrev <buffer> "h "<C-R>=expand("%<").".h"<CR>

" some comman words
iabbrev <buffer> uint uint32_t
iabbrev <buffer> u32 uint32_t
iabbrev <buffer> u64 uint64_t
iabbrev <buffer> uch unsigned char

" comment:
iabbrev <buffer> //f // File:
iabbrev <buffer> //a // Author: tan.sin.log
iabbrev <buffer> //d // Date: <C-R>=strftime("20%y-%m-%d")<CR>
iabbrev <buffer> //p // >>Para: 
iabbrev <buffer> //r // <<Return:

" highlight: Macro Special
" 宏定义
" match Special /\<[A-Z_]\{2,}\>/
syntax match Macro /\<[A-Z_]\{2,}\>/
" 类或结构体定义
" 2match Identifier /\<\(C\|tag\)[A-Z][A-Za-z]\+\>/
syntax match Special /\<\(C\|tag\|Tab\)[A-Z][A-Za-z]\+\>/
" 以大写字母开头的函数或成员名
syntax match Identifier /\<[A-Z][a-z][a-zA-Z]\+\>/
" 以 :: 名字空间连接的标志符
syntax match cType /\w\+::[[:alnum:]:]\+/
setlocal iskeyword-=:

" 以 imap 方式插入括号对会有些问题
" left brace pairs
inoremap <buffer> ( ()<Esc>i
inoremap <buffer> [ []<Esc>i
inoremap <buffer> { {<CR>}<Esc>O
" right brace pairs
inoremap <buffer> } { }<Esc>i
inoremap <buffer> ) ()
inoremap <buffer> ] []
" quation pairs
inoremap <buffer> " ""<Esc>i
inoremap <buffer> ' ''<Esc>i

finish
