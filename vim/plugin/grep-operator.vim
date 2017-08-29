nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if exists("b:grep_srcdir")
        let srcdir = b:grep_srcdir
    else
        let srcdir = "."
    endif

    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif

    silent execute "grep! -RI --exclude=.tags " . shellescape(@@) . " "
        \ . srcdir
    copen 5
    redraw!

    let @@ = saved_unnamed_register
endfunction
