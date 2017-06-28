if did_filetype()
    finish
endif
if getline(1) =~# '^#!.*csi.*'
    setfiletype scheme
endif
