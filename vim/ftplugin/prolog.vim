let g:prolog_library_path_added = 0

fun! Prolog_send_pred(pred)
    if g:prolog_library_path_added == 0 
        call Prolog_add_local_libraries()
    endif

    let ss = escape(a:pred, '\"')
    call system("screen -p PL -X stuff \"" . ss . "\n\"")
endfun

fun! Prolog_add_local_libraries()
    let path = 'assert(library_directory(''' . getcwd() . '/'
    call system("screen -p PL -X stuff \"" . path . "')).\n\"")
    call system("screen -p PL -X stuff \"" . path . "lib')).\n\"")
    call system("screen -p PL -X stuff \"" . path . "src')).\n\"")
    let g:prolog_library_path_added = 1
endfun

fun! Prolog_eval_defun()
    let pos = getpos('.')
    let curlinenr = line('.')

    if getline(curlinenr) =~? '\v^\s*$' 
        return
    endif

    while curlinenr > 0 
        if getline(curlinenr) =~? '\v^\S'
            call Prolog_read_exp(curlinenr)
            break
        endif
        let curlinenr = curlinenr - 1
    endwhile
endfun

fun! Prolog_read_exp(linenr)
    let curline = getline('.').
endfun


nnoremap <silent> <leader>es :call Prolog_eval_defun()<cr>
nnoremap <silent> <leader>ef :silent! write<cr>
    \:call Prolog_send_pred("consult('" . expand("%:p") . "').")<cr>
