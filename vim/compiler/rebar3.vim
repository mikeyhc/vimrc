if exists('current_compiler')
  finish
endif
let current_compiler = 'rebar3'

CompilerSet makeprg=rebar3\ compile
CompilerSet errorformat=%f:%l:%c\ %m,%f:%l:\ %m,%-G%.%#,%-G%.%#
