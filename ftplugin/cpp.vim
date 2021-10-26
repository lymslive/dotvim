" Vim filetype plugin file of mine
" Language:	C++
" Maintainer:	lymslive
" Last Changed: 2016-01-08

if exists("b:did_ftplugin") && b:did_ftplugin
    finish
endif

PI clang

" 处理大文件折叠
let s:iLargeFile = 1024 * 100
let b:iSize = getfsize(expand('%:p'))
if (b:iSize > s:iLargeFile || b:iSize == -2) " && &foldmethod ==? 'syntax'
    setlocal foldmethod=indent
else
    setlocal foldmethod=syntax
endif
setlocal foldlevelstart=99

" 注释
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>
vnoremap <buffer> ,,x <ESC>:call wraptext#func#wrap('/*', '*/', visualmode())<CR>
vnoremap <buffer> ,X <ESC>:call wraptext#func#wrap('#if 0', '#endif', visualmode())<CR>

" 空格快捷键模式
" silent! call Spacebar#SpaceModeSelect('Cpp')

" Compile:
" compile current file
setlocal makeprg=g++\ -std=c++11\ -c\ %
" nnoremap <buffer> <F9> :make<CR>
nnoremap <buffer> <F9> :AsyncRun make<CR>
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
iabbrev <buffer> -t template <typename T>

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
" doxygen comment
iabbrev <buffer> //x /** */<Left><Left><Left>
iabbrev <buffer> @a @author lymslive
iabbrev <buffer> @b @brief
iabbrev <buffer> @c @code
iabbrev <buffer> @d @date <C-R>=strftime("20%y-%m-%d")<CR>
iabbrev <buffer> @e @details
iabbrev <buffer> @f @file <C-R>=expand('%')<CR>
iabbrev <buffer> @m @remark
iabbrev <buffer> @n @note
iabbrev <buffer> @p @param
iabbrev <buffer> @r @return
iabbrev <buffer> @v @retval
iabbrev <buffer> @w @warning

" block jumping
nnoremap [c :call search('^\s*class', 'bW')<CR>
nnoremap ]c :call search('^\s*class', 'W')<CR>
nnoremap [s :call search('^\s*namespace', 'bW')<CR>
nnoremap ]s :call search('^\s*namespace', 'W')<CR>

" highlight: Macro Special
" 宏定义
" match Special /\<[A-Z_]\{2,}\>/
syntax match Macro /\<[A-Z_]\{2,}\>/
" 类或结构体定义
" 2match Identifier /\<\(C\|tag\)[A-Z][A-Za-z]\+\>/
syntax match Special /\<\(C\|tag\|Tab\)[A-Z][A-Za-z]\+\>/
syntax match Type /\<[a-z_]\+_t\>/
" 以大写字母开头的函数或成员名
syntax match Identifier /\<[A-Z][a-z][a-zA-Z]\+\>/
" 以 :: 名字空间连接的标志符
" syntax match cType /\w\+::[[:alnum:]_:]\+/
syntax match Delimiter /[[:alnum:]_:]\+::\ze\w\+/
setlocal iskeyword-=:

finish
