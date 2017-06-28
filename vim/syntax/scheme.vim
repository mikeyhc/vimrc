syn match	schemeChar	oneline    "#\\tab"
syn match	schemeError	oneline    !#\\tab[^ \t\[\]()";]\+!

if version >= 508 || !exists("did_scheme_syntax_inits")
  if version < 508
    let did_scheme_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink schemeChar		Character
  delcommand HiLink
endif
