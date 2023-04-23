" Vim filetype plugin file of mine
" Language:	rust
" Maintainer:	lymslive
" Last Changed: 2023-02-25

if exists("b:did_ftplugin") && b:did_ftplugin
    finish
endif

silent! packadd rust.vim

" 注释
nnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "n")<CR>
vnoremap <buffer> ,x <ESC>:call wraptext#func#wrap('// ', '', "v")<CR>

" 在终端执行 cargo 命令，已有的终端需 cd 至在项目目录下
noremap <buffer> <F9> :Shell cargo build<CR>
noremap <buffer> <F10> :Shell cargo check<CR>

" 查找项目的 Cargo.toml
noremap <buffer> <F4> :edit findfile("Cargo.toml", ".;")<CR>

iabbrev <buffer> utd use std::;<Left>
inoreabbrev <buffer> #d #[derive()]<Left><Left>
