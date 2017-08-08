set autoindent
set history=50
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set t_Co=256
set cmdheight=1
set number relativenumber
set tags=.tags

filetype plugin indent on
set expandtab

" set early so can be replaced in ft blocks below
let g:ctag_exec = "ctags"
let g:ctag_options = "--verbose=y -R -f .tags"

execute pathogen#infect()

" common syntax rules {{{
syntax on
colorscheme slate
highlight VertSplit ctermfg=236
highlight StatusLine ctermbg=235 ctermfg=white cterm=bold
highlight StatusLineNC ctermbg=235 ctermfg=grey cterm=bold
highlight WildMenu ctermbg=red ctermfg=white
set fillchars+=vert:\ 
"}}}

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
    au FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2
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
    au FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
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

" ## added by OPAM user-setup for vim / base ## 8a3125e39f347f6b9a1b167d8e564281 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
    let l:file = s:opam_share_dir . "/vim/syntax/ocp-indent.vim"
    execute "source " . l:file
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
    let l:file = s:opam_share_dir . "/vim/syntax/ocpindex.vim"
    execute "source " . l:file
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
    let l:dir = s:opam_share_dir . "/merlin/vim"
    execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline, ' ')))
for tool in s:opam_available_tools
    call s:opam_configuration[tool]()
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

let g:syntastic_ocaml_checkers = ['merlin']
nnoremap <silent> <localleader>ml :MerlinLocate<cr>
augroup ocaml_settings
    au!
    au FileType ocaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
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
    au Filetype python setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}

" yaml settings {{{
augroup yaml_settings
    au!
    au FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2
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
let g:syntastic_rust_checkers = ['rustc']

augroup rust_settings
    au!
    au FileType rust setlocal tags=./rusty-tags.vi;/
    au FileType rust let Tlist_Ctags_Cmd="/home/mikey/.cargo/bin/rusty-tags"
    au FileType rust let g:ctag_exec = "rusty-tags"
    au FileType rust let g:ctag_options = "vi"
    au FileType rust nnoremap <buffer> <localleader>c I//<esc>
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
augroup c_settings
    au!
    au FileType c setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
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
augroup END
" }}}

" overlength settings {{{
highlight OverLength ctermbg=red ctermfg=white

fun! UpdateMatch()
    if &ft =~ '^java$'
        match OverLength /\v(%100v.+|( |\t)+$)/
    else
        match OverLength /\v(%80v.+|( |\t)+$)/
    endif
endfun

au BufEnter,BufWinEnter * call UpdateMatch()
" }}}

highlight Folded ctermbg=240 ctermfg=white

noremap <silent> <Leader>e :Errors<cr>
noremap <Leader>s :SyntasticToggleMode<cr>
let g:syntastic_auto_loc_list=1
let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_include_dirs = [ '/usr/lib64/swipl-7.1.29/include',
            \ '/usr/include/SDL2' ]
let g:syntastic_cpp_include_dirs = [ '/usr/lib64/swipl-7.1.29/include',
            \ '/usr/include/SDL2' ]
" let g:syntastic_erlc_include_path = [ 'src' ]
let g:slimv_swank_cmd = '! screen -d -m -t REPL-CCL /usr/bin/ccl --load ~/.vim/bundle/slimv/slime/start-swank.lisp'

noremap <silent> tu :call GHC_BrowseAll()<cr>
noremap <silent> tw :call GHC_ShowType(1)<cr>

function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction

let g:hdevtools_options = '-g-isrc -g-hide-package -gmonads-tf -i.
            \-g-package-conf='.FindCabalSandboxRootPackageConf()

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

let tlist_prolog_settings='prolog;p:predicate'

nnoremap <silent> <F7> :execute '!' . g:ctag_exec . ' ' . g:ctag_options<CR>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <leader>. :CtrlPTag<CR>
nnoremap <silent> <leader>n :lnext<CR>
nnoremap <silent> <leader>p :lprev<CR>

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

hi User1 ctermfg=172 ctermbg=235
hi User2 ctermfg=red ctermbg=235
hi User3 ctermfg=169 ctermbg=235
hi User4 ctermfg=lightgreen  ctermbg=235
hi User5 ctermfg=yellow ctermbg=235
" }}}

hi LineNr ctermfg=130 ctermbg=0

" vim mappings {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

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
" }}}

nnoremap <silent> <leader>nt :NERDTreeToggle<cr>
nnoremap <silent> <leader>gt :GundoToggle<cr>

iabbrev auth@ author: michael blockley <mikey@spotify.com>

set printexpr=


" LVSTHM

autocmd VimEnter * echo ">^.^<"

nnoremap <localleader>- ddp
nnoremap <localleader>_ ddkP

inoremap <c-u> <esc>vawUei
nnoremap <c-u> vawUe

iabbrev @@ mikey@spotify.net

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
