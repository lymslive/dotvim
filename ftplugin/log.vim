
if !exists('s:load_logview')
    let s:load_logview = logview_7#plugin#load()
endif

if !exists('b:load_logview')
    let b:load_logview = logview_7#plugin#onftLOG()
endif
