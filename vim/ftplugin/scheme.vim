let b:is_chicken=1
setl complete+=,k~/.scheme-word-list
setl include=\^\(\\(use\\\|require-extension\\)\\s\\+
setl includeexpr=substitute(v:fname,'$','.scm','')
setl path+=/usr/lib/chicken/6
setl suffixesadd=.scm

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

setl lispwords+=let-values,condition-case,with-input-from-string
setl lispwords+=with-output-to-string,handle-exceptions,call/cc,rec,receive
setl lispwords+=call-with-output-file

nmap <silent> == :call Scheme_indent_top_sexp()<cr>

" Indent a toplevel sexp.
fun! Scheme_indent_top_sexp()
	let pos = getpos('.')
	silent! exec "normal! 99[(=%"
	call setpos('.', pos)
endfun

nmap <silent> <leader>es :call Scheme_eval_defun()<cr>
nmap <silent> <leader>ef :write<cr>:call Scheme_send_sexp("(load \"" . expand("%:p"). "\")\n")<cr>

fun! Scheme_send_sexp(sexp)
    let ss = escape(a:sexp, '\"')
    call system("screen -p CSI -X stuff \"" . ss . "\n\"")
endfun

fun! Scheme_eval_defun()
    let pos = getpos('.')
    silent! exec "normal! 99[(yab"
    call Scheme_send_sexp(@")
    call setpos('.', pos)
endfun
