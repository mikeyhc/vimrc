" build & test with rebar3, sync via dispatch
setlocal makeprg=rebar3\ compile
setlocal errorformat=%f:%l:%c:\ %m,%f:%l:\ %m,%-G%.%#
call setenv('REBAR_COLOR', 'none')

function! ErlangDispatch(args) abort
	execute 'Dispatch rebar3 ' . a:args
				\ . " 2>&1 | sed -E 's/\\x1b\\[[0-9;]*[A-Za-z]//g'"
endfunction

nnoremap <buffer> <leader>ec :call ErlangDispatch('compile')<cr>
nnoremap <buffer> <leader>es :call ErlangDispatch('escriptize')<cr>
nnoremap <buffer> <leader>et :call ErlangDispatch('eunit')<cr>
nnoremap <buffer> <leader>eT :call ErlangDispatch('eunit --module=' . expand('%:t:r'))<cr>
