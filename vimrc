" install plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'dense-analysis/ale'

" clojure specific
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'guns/vim-clojure-static'

" erlang specific
Plug 'vim-erlang/vim-erlang-runtime'
call plug#end()

syntax on
filetype plugin indent on
set t_Co=256 " enable 256-color
colorscheme murphy
set nu rnu
set complete=.,w,b,u
set completeopt=menuone,noinsert,noselect

" essentials
inoremap jk <esc>
nnoremap / /\v
nnoremap <leader>nh :nohlsearch<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>tp :set paste!<cr>
nnoremap <leader>N :setlocal number! relativenumber!<cr>

" preview window
set splitbelow
set previewheight=15
call setenv('NO_COLOR', '1')

" quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
augroup qf_window
  autocmd!
  autocmd FileType qf wincmd J
  autocmd FileType qf resize 15
augroup END

" location list
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>

" arrows
function! ArrowMappings()
  if !exists("b:arrows_mapped")
    let b:arrows_mapped = 1
    for k in ['<left>','<right>','<up>','<down>']
      execute 'inoremap <buffer> ' . k . ' <nop>'
      execute 'nnoremap <buffer> ' . k . ' <nop>'
    endfor
  endif
endfunction  
augroup mapping_update | au! | au BufEnter,BufWinEnter * call ArrowMappings() | augroup END

"  statusline   
set statusline=\ %3*%y\ %*%4*%<%f%*%5*\ %{exists('*fugitive#statusline')?fugitive#statusline():''}%*%(\ %2*%m%)%r%*%1*%=%*%5*\ %l%*%2*/%L\ %p%%\ %*%1*\ %5*%v\ %*

" color the vsplit
set fillchars+=vert:\
hi VertSplit ctermfg=235 ctermbg=235
hi WinSeparator ctermfg=235 ctermfg=235

" colours
hi StatusLine   ctermfg=white ctermbg=235
hi StatusLineNC ctermfg=grey  ctermbg=235
hi User1 ctermfg=172        ctermbg=235
hi User2 ctermfg=red        ctermbg=235
hi User3 ctermfg=169        ctermbg=235
hi User4 ctermfg=lightgreen ctermbg=235
hi User5 ctermfg=yellow     ctermbg=235

" ALE config
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'erlang': ['erlang_ls'],
      \ }
let g:ale_fixers = {
      \ 'erlang': ['erlfmt'],
      \ }

" the most important mapping
autocmd VimEnter * if v:errmsg ==# "" | echom ">^.^<" | else | echom ">x.x< " . v:errmsg | endif
