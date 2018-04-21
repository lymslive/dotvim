#! /usr/bin/env svex
" batch replace v:false v:true in all *.vim files under pwd

let lpFiles = glob(getcwd() . '/**/*.vim' , '', 1)
for pFile in lpFiles
    if pFile =~? 'Sessionx\?.vim'
        continue
    endif

    " echo pFiles
    " continue

    execute 'edit ' . pFile
    g!/^\s*"/ s/\<class#TRUE\>/g:class#TRUE/ | s/\<class#FALSE\>/g:class#FALSE/
    update
endfor

finish

" when the file is edit in another vim instance
" svex will fail silently
