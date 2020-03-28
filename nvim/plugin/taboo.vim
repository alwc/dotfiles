if has('mac')
    map <M-t> :TabooOpen<Space>
    map <M-m> :TabooRename<Space>
else
    map <A-t> :TabooOpen<Space>
    map <A-m> :TabooRename<Space>
endif

let g:taboo_tab_format = " %N   %f%m "
let g:taboo_renamed_tab_format = " %N   %l%m "
