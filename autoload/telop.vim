" Show telop on your buffer
" Version: 0.1.0
" Author : wara <kusabashira227@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! telop#stroverwrite(below, above, startidx) abort
  let border  = strlen(a:above) + a:startidx
  let overlen = a:startidx - strlen(a:below)
  let lhs = (a:startidx < 1)? '': a:below[: a:startidx-1]
  let rhs = repeat(' ', overlen) . a:above . a:below[border :]
  return lhs . rhs
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
