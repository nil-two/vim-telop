" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! telop#stroverwrite(below, above, startidx) abort
  let border = strlen(a:above)
  return a:above . a:below[border :]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
