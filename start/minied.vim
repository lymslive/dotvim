" vimrc for mini-editor with less set/maps.

let g:AppMode = "MiniEditor"

set formatoptions+=mB
set autowriteall
set textwidth=78
set autoindent

" normal maps
nnoremap <CR> :
nnoremap <Space> }
nnoremap <S-Space> {
nnoremap ;w :update<cr>
nnoremap ;W :wall<cr>
nnoremap ;q :quit<cr>
nnoremap ;Q :qall<CR>
nnoremap ;o :copy .<CR>
nnoremap ;O :copy -1<CR>
vnoremap ;o :copy '><CR>
vnoremap ;O :copy -1<CR>
nnoremap ,o :call append(line("."), "")<CR>
nnoremap ,O :call append(line(".")-1, "")<CR>

" Insert maps
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-f> <Right>
noremap! <C-b> <Left>
" noremap! <Esc>f <C-Right>
" noremap! <Esc>b <C-Left>
noremap! <C-p> <Up>
noremap! <C-n> <Down>
noremap! <C-d> <Del>
inoremap <C-v> <PageDown>
" inoremap <Esc>v <PageUp>
inoremap <Tab> <C-P>
inoremap <C-Q> <C-V>
inoremap <C-K> <C-O>d$
" inoremap <Esc>d <C-O>dw
" inoremap <Esc>h <C-O>db
inoremap <C-_> <C-O>u

" To full-editor vimrc
nnoremap <Tab> :mapclear<CR>:mapclear!<CR>:source $VIMHOME/start/fulled.vim<CR>


