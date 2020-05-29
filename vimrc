" vim settings {{{
set autoindent
set history=50
set hidden
set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set nocompatible
set visualbell
set t_vb=
set t_Co=256
set cmdheight=1
set number relativenumber
set tags=.tags
set expandtab
set printexpr=
set nobackup
set noundofile
set mouse=
set encoding=utf-8
filetype plugin indent on
" }}}

" set early so can be replaced in ft blocks below
let g:ctag_exec = "ctags"
let g:ctag_options = "--verbose=y -R -n -f .tags"

execute pathogen#infect()

" common syntax rules {{{
syntax on
" colorscheme slate
colorscheme koehler
highlight VertSplit ctermfg=236
highlight StatusLine ctermbg=235 ctermfg=white cterm=bold
highlight StatusLineNC ctermbg=235 ctermfg=grey cterm=bold
highlight WildMenu ctermbg=red ctermfg=white
highlight Search ctermfg=black ctermbg=cyan
set fillchars+=vert:\ 
"}}}

let g:ctrlp_custom_ignore = {
    \ 'dir': '\(venv\|target\|_build\|logs\|ebin\)',
    \ 'file': '.beam$'
    \ }

" .h filetype settings {{{
augroup h_filetype
    au!
    au BufRead,BufNewFile *.h set ft=c
augroup END
" }}}

" haskell settings {{{
augroup hs_filetype
    au!
    au BufRead,BufNewFile *.hsc setlocal ft=haskell
    au BufRead,BufNewFile *.lhsc setlocal ft=lhaskell
    au BufRead,BufNewFile *.cabal setlocal ft=cabal

    au FileType haskell,lhaskell setlocal tabstop=4 shiftwidth=4 softtabstop=4
    au FileType cabal setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" Shell indent settings {{{
augroup sh_indent
    au!
    au FileType sh setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
" }}}

" LaTeX indent settings {{{
augroup tex_indent
    au!
    au FileType tex setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType plaintex setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" Javascript settings {{{
augroup js_filetypes
    au!
    au BufRead,BufNewFile *.tsx setlocal ft=typescript
    au FileType javascript,typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" Racket settings {{{
augroup racket_settings
    au!
    au BufReadPost *.rkt,*.rktl set filetype=racket
    au filetype racket set lisp
    au filetype racket set autoindent
augroup END
" }}}

" Scheme settings {{{
augroup scheme_settings
    au!
    au BufRead,BufNewFile *.setup setfiletype scheme
    au BufRead,BufNewFile *.meta setfiletype scheme
    au FileType scheme let mysyntaxfile="$HOME/.vim/syntax/scheme.vim"
augroup END
"}}}

" Java settings {{{
function! MvnDo(command)
    let currwin=winnr()
    execute 'Mvn ' . a:command
    execute currwin . 'wincmd w'
    redraw!
endfunction

let g:maven_detect_root = 0
let g:syntastic_java_javac_config_file_enabled = 1

nnoremap <silent> <localleader>mt :execute MvnDo('test')<cr>
nnoremap <silent> <localleader>mb :execute MvnDo('build')<cr>
nnoremap <silent> <localleader>mp :execute MvnDo('package')<cr>

nnoremap <localleader>jI <Plug>(JavaComplete-Imports-AddMissing)
nnoremap <localleader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
nnoremap <localleader>ji <Plug>(JavaComplete-Imports-AddSmart)
nnoremap <localleader>jii <Plug>(JavaComplete-Imports-Add)

inoremap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
inoremap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
inoremap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
inoremap <C-j>ii <Plug>(JavaComplete-Imports-Add)

nnoremap <localleader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

inoremap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

nnoremap <localleader>jA <Plug>(JavaComplete-Generate-Accessors)
nnoremap <localleader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nnoremap <localleader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nnoremap <localleader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nnoremap <localleader>jts <Plug>(JavaComplete-Generate-ToString)
nnoremap <localleader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nnoremap <localleader>jc <Plug>(JavaComplete-Generate-Constructor)
nnoremap <localleader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

inoremap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
inoremap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
inoremap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

vnoremap <localleader>js <Plug>(JavaComplete-Generate-AccessorSetter)
vnoremap <localleader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
vnoremap <localleader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)

nnoremap <silent> <buffer> <localleader>jn
    \ <Plug>(JavaComplete-Generate-NewClass)
nnoremap <silent> <buffer> <localleader>jN
    \ <Plug>(JavaComplete-Generate-ClassInFile)

augroup java_settings
    au!
    au FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType java setlocal omnifunc=javacomplete#Complete
"    au FileType java let g:ctrlp_custom_ignore = {
"                \ 'dir': [ 'apidocs', 'classes', 'invoker',
"                \          'javadoc-bundle-options', 'lib',
"                \          'maven-archiver', 'maven-status',
"                \          'surefire-reports', 'apidocs',
"                \        ],
"                \ }
augroup END
"}}}

" Vimscript file settings {{{
augroup filetype_vim
    au!
    au! FileType vim setlocal tabstop=4 softtabstop=4 shiftwidth=4
        \ foldmethod=marker
augroup END
" }}}

" .tpl filetype settings {{{
augroup tpl_filetype_settings
    au BufRead,BufNewFile *.tpl setlocal ft=html
augroup END
" }}}

" html settings {{{
augroup html_settings
    au!
    au FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
    au FileType css setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
" }}}

" svg settings {{{
augroup svg_settings
    au!
    au FileType svg setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
" }}}

" omnicomplete color settings {{{
highlight Pmenu ctermbg=black ctermfg=white
highlight PmenuSel ctermbg=red ctermfg=white
" }}}

" erlang settings {{{
augroup other_erlang_settings
    au!
    au! BufRead,BufNewfile *.app setlocal ft=erlang
    au! BufRead,BufNewfile Emakefile setlocal ft=erlang
    au! BufRead,BufNewfile rebar.config setlocal ft=erlang
    au! FileType erlang setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END
" }}}

" .rst filetype settings {{{
augroup rst_settings
    au!
    au FileType rst setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" clojure settings {{{
nnoremap <silent> <localleader>ce :%Eval<cr>
nnoremap <silent> <localleader>ct :RunTests<cr>
augroup clojure_settings
    au!
    au FileType clojure setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType clojure setlocal omnifunc=syntaxcomplete#Complete
augroup END
" }}}

" ocaml settings {{{

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

let g:syntastic_ocaml_checkers = ['merlin']
nnoremap <silent> <localleader>ml :MerlinLocate<cr>
augroup ocaml_settings
    au!
    au FileType ocaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType ocaml execute "set rtp+=" .
        \ substitute(system('opam config var share'), '\n$', '', '''') .
        \ "/ocp-indent/vim/indent/ocaml.vim"
augroup END
" }}}

" puppet settings {{{
augroup puppet_settings
    au!
    au FileType puppet setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}

" json settings {{{
augroup json_settings
    au!
    au Filetype json setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}

" python settings {{{
augroup python_settings
    au!
    au Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END
" }}}

" yaml settings {{{
augroup yaml_settings
    au!
    au FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
augroup END
" }}}

" {{{ Linker file settings
augroup linker_settings
    au!
    au FileType ld setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END
" }}}

" {{{ asm settings
augroup asm_settings
    au!
    au filetype asm setlocal shiftwidth=4 tabstop=4 softtabstop=4
    au filetype asm setlocal indentexpr=
augroup END
" }}}

" rust settings {{{
let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['clippy']
let g:racer_cmd = '/home/mikey/.cargo/bin/racer'

augroup rust_settings
    au!
    au FileType rust nnoremap <buffer> <localleader>c I//<esc>
    au FileType rust let b:grep_srcdir = "src/**.rs"
    au FileType rust nmap gd <Plug>(rust-def)
    au FileType rust nmap gs <Plug>(rust-def-split)
    au FileType rust nmap gx <Plug>(rust-def-vertical)
    au FileType rust nmap <leader>gd <Plug>(rust-doc)
augroup END
" }}}

" go settings {{{
let g:go_fmt_command = "goimports"
let g:go_bin_path = "/home/mikey/go/bin/"
let g:go_doc_command = ["go", "doc"]
augroup go_settings
    au!
    au FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=4
    au FileType go nnoremap gr :GoRun %<cr>
augroup END
" }}}

" ada settings {{{
augroup ada_settings
    au!
    au FileType ada setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}

" prolog settings {{{
augroup prolog_settings
    au BufRead,BufNewFile *.pl setlocal ft=prolog
    au FileType prolog setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END
" }}}

" XML settings {{{
augroup xml_settings
    au!
    au FileType xml setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}

" C settings {{{
let g:syntastic_c_config_file=".syntastic_c_config"
augroup c_settings
    au!
    au FileType c setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
    au FileType c setlocal foldmethod=syntax
    au FileType c setlocal cindent
    au FileType c setlocal cinoptions=:0t0
augroup END
" }}}

" perl settings {{{
augroup perl_settings
    au!
    au FileType perl set shiftwidth=4 softtabstop=4 tabstop=4
augroup END
" }}}

" markdown settings {{{
augroup markdown_settings
    au!
    au FileType markdown setlocal shiftwidth=2 softtabstop=2 tabstop=2
    au FileType markdown onoremap <buffer> ih
                \ :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
    au FileType markdown onoremap <buffer> ah
                \ :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
    highlight link markdownItalic htmlBold
augroup END
" }}}

" picolisp settings {{{
augroup picolisp
    au!
    au FileType picolisp setlocal shiftwidth=3 softtabstop=3 tabstop=3
augroup END
" }}}

" elm settings {{{
augroup elm
    au!
    au FileType elm setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
augroup END
" }}}

" protobuf settings {{{
augroup protobuf
    au!
    au FileType proto setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
augroup END
" }}}

" overlength settings {{{
highlight OverLength ctermbg=red ctermfg=white

fun! UpdateMatch()
    if &ft =~ '^java$'
        match OverLength /\v(%100v.+|( |\t)+$)/
    elseif expand('%:t:r') =~ '^REPL$'
    elseif &ft =~ '^svg$'
        match OverLength /\v(%100v.+|( |\t)+$)/
    else
        match OverLength /\v(%81v.+|( |\t)+$)/
    endif
endfun

au BufEnter,BufWinEnter * call UpdateMatch()
" }}}

noremap <silent> <Leader>e :Errors<cr>
noremap <Leader>s :SyntasticToggleMode<cr>

" plugin settings {{{
function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction

let g:hdevtools_options = '-g-isrc -g-hide-package -gmonads-tf -i.
            \-g-package-conf='.FindCabalSandboxRootPackageConf()
let g:syntastic_auto_loc_list=1
let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_include_dirs = [ '/usr/lib64/swipl-7.1.29/include',
            \ '/usr/include/SDL2' ]
let g:syntastic_cpp_include_dirs = [ '/usr/lib64/swipl-7.1.29/include',
            \ '/usr/include/SDL2' ]
" let g:syntastic_erlc_include_path = [ 'src' ]
let g:slimv_swank_cmd = '! screen -d -m -t REPL-CCL /usr/bin/ccl --load ~/.vim/bundle/slimv/slime/start-swank.lisp'
let tlist_prolog_settings='prolog;p:predicate'
" }}}

" gitgutter {{{
highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=lightred

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

let g:gitgutter_eager = 1
" }}}

" plugin keymappings {{{
nnoremap <silent> <F7> :execute '!' . g:ctag_exec . ' ' . g:ctag_options<CR>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <leader>. :CtrlPTag<CR>
nnoremap <silent> <leader>n :lnext<CR>
nnoremap <silent> <leader>p :lprev<CR>
nnoremap <silent> <leader>nt :NERDTreeToggle<cr>
nnoremap <silent> <leader>gt :GundoToggle<cr>
noremap <silent> tu :call GHC_BrowseAll()<cr>
noremap <silent> tw :call GHC_ShowType(1)<cr>
" }}}

function! HighlightSource()
    return synIDattr(synID(line("."), col("."), 1), "name")
endfunction

" statusline {{{
set statusline=
set statusline+=%1*\ %n\ %*				"buffer number
set statusline+=%5*%{&ff}%*				"file format
set statusline+=%3*%y%*					"file type
set statusline+=%5*\ %{''.(&fenc!=''?&fenc:&enc).''}	"encoding
set statusline+=%4*\ %<%f%*				"relative path
set statusline+=%5*\ %{fugitive#statusline()}%*         "fugitive#statusline
set statusline+=%2*\ %m%*				"modified flag
set statusline+=%1*%=%*                 "spacer
set statusline+=%4*\ %{HighlightSource()}%*             "current vim highlight
set statusline+=%5*\ %l%*			    "current line
set statusline+=%2*/%L\ %p%%\ %*	    "total lines
set statusline+=%1*\ %5*%v\ %*			"virtual column number
set statusline+=%2*0x%04B\ %*			"cursor character
" }}}

" colours {{{
hi User1 ctermfg=172 ctermbg=235
hi User2 ctermfg=red ctermbg=235
hi User3 ctermfg=169 ctermbg=235
hi User4 ctermfg=lightgreen  ctermbg=235
hi User5 ctermfg=yellow ctermbg=235
hi LineNr ctermfg=130 ctermbg=0
hi Folded ctermbg=240 ctermfg=white
" }}}

" vim mappings {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>
" arrow mappings {{{
function! ArrowMappings()
    if bufname('%') !=? 'REPL' && !exists("b:arrows_mapped")
        let b:arrows_mapped = 1
        inoremap <buffer> <esc> <nop>
        inoremap <buffer> <left> <nop>
        inoremap <buffer> <right> <nop>
        inoremap <buffer> <up> <nop>
        inoremap <buffer> <down> <nop>
        nnoremap <buffer> <left> <nop>
        nnoremap <buffer> <right> <nop>
        nnoremap <buffer> <up> <nop>
        nnoremap <buffer> <down> <nop>
    endif
endfunction

augroup mapping_update
    au!
    au BufEnter,BufWinEnter * call ArrowMappings()
augroup END
" }}}

nnoremap <silent> <leader>lo :lop<cr>
nnoremap <silent> <leader>lc :lcl<cr>
nnoremap <silent> <leader>ll :Last<cr>
nnoremap <silent> []l :ll<cr>
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [l :lprevious<cr>

nnoremap <silent> <leader>co :copen<cr>
nnoremap <silent> <leader>cc :ccl<cr>
nnoremap <silent> []c :cl<cr>
nnoremap <silent> ]c :cnext<cr>
nnoremap <silent> [c :cprevious<cr>

nnoremap <silent> <leader>tp :set paste!<cr>
" }}}

" view settings {{{
augroup view_settings
    au!
    au BufWinLeave *.* mkview
    au BufWinEnter *.* silent loadview
augroup END
" }}}

iabbrev auth@ author: michael blockley <mikey@spotify.com>

" workaround for https://github.com/vim/vim/issues/1671
if has("unix")
    let s:uname = system("echo -n \"$(uname)\"")
    if !v:shell_error && s:uname == "Linux"
        set t_BE=
    endif
endif

" LVSTHM

nnoremap <localleader>- ddp
nnoremap <localleader>_ ddkP

inoremap <c-u> <esc>vawUei
nnoremap <c-u> vawUe

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<lv`>l
vnoremap <leader>' <esc>`>a'<esc>`<i"<esc>`<lv`>l

onoremap p i(

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>

noremap <silent> <leader>sl :execute "rightbelow split " . bufname("#")<cr>

nnoremap / /\v
nnoremap <leader>nh :nohlsearch<cr>

nnoremap <leader>N :setlocal number! relativenumber!<cr>
nnoremap <leader>f :call FoldColumnToggle()<cr>

nnoremap <leader>cp :-1r !xclip -o -sel clip<CR>

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

noremap <leader>q :call QuickFixToggle()<cr>

let g:quickfix_is_open = 0
function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

autocmd VimEnter * redraw
autocmd VimEnter * echom ">^.^<"
